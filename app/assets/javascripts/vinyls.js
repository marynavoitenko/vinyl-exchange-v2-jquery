$( document ).on('turbolinks:load', function() {
    attachEventListeners();
});

function attachEventListeners() {
    // GET vinyls index via ajax and display
    $('.vinyls_index').on('click', getVinylsIndex);
    // GET next vinyl and display without page refresh
    $('.next').click( loadNextVinyl );
    // GET genres and display on vinyl show
    $('.load_genres').click( loadGenres );

    function getVinylsIndex() {
        $.ajax({
            type: 'GET',
            url: '/vinyls/my_vinyls.json'
        }).done(function(data) {
            $('.vinyls_index').hide();
            let divHtml = '';
            data.sort((a,b) => b.inventory - a.inventory );
            $.each(data, function( index, value ) {
                
                const newVinyl = new Vinyl(value);
                divHtml += newVinyl.formatIndex();
            });
        
            $('#vinyls_table').html(divHtml);
    
            $('.delete_vinyl').click( deleteVinyl ); 
        });
    };
    
    function deleteVinyl() {
        const id = $(this).attr("id");
        if (confirm('Are you sure you want to delete this vinyl?')) {
            $.ajax({
            type: 'DELETE',
            url: `/vinyls/${id}`
            }).done(function(data) {
                $(`#vinyl_${id}`).remove();
            });
        }
        return false;
    };

    
    function loadNextVinyl() {
        // if first item, get id from url and store in hidden div
        let currentId = $("#current_vinyl_id").html();
        if (currentId == 0) {
            const url = window.location.href;
            const id = url.split("/").pop();
            $("#current_vinyl_id").html(id);
            currentId = $("#current_vinyl_id").html();
        }

        $('#genres').hide();
        $.ajax({
            type: 'GET',
            url: `/vinyls/${currentId}/next`
        }).done(function(data) {
            const newVinyl = new Vinyl(data);
            const divHtml = newVinyl.formatIndex();
            $('#vinyls_table').html(divHtml);
            $("#current_vinyl_id").html(newVinyl.id);
        });
    };    

    function loadGenres() {
        $('#genres').show();
        const vinylId = $("#current_vinyl_id").html();
        $.ajax({
            type: 'GET',
            url: `/vinyls/${vinylId}.json`
        }).done(function(data) {
            const newVinyl = new Vinyl(data);
            $('#genres').html("");
            if (newVinyl.genres.length > 0) {
                let genreHtml = '<ul class="list-group">';
                for (let i = 0; i < newVinyl.genres.length; i++) {
                    genreHtml += newVinyl.genres[i].formatItem();
                    $('#genres').append(genreHtml);
                };
                genreHtml += '</ul>';
            } else {
                $('#genres').html('Vinyl has no genres.');
            }
            
        });
    }

    $('.js-new-vinyl-form').submit(function(e) {
        e.preventDefault();
        const values = $(this).serialize();
        $('.alert').hide();
        $.ajax({
            type: 'POST',
            data: values, 
            url: '/vinyls/',
            dataType: 'json'
        }).done(function(data) {
            const newVinyl = new Vinyl(data);
            const divHtml = newVinyl.formatIndex();
            $('#vinyls_table').append(divHtml);
        }).error(function(e) {
            const err = JSON.parse(e.responseText);
            $('.alert').show();
            const errorHtml = "";
            $.each(err.errors, function(index, value) {
                errorHtml += value + '<br>';
            });
            $('.alert').html(errorHtml);
        });
    });


    class Vinyl {
        constructor(vinyl) {
            this.id = vinyl.id;
            this.title = vinyl.title;
            this.price = vinyl.price;
            this.inventory = vinyl.inventory;
            this.forSale = vinyl.forSale;
            this.artistId = vinyl.artist.id;
            this.artistName = vinyl.artist.name;
            let genres = [];
            vinyl.genres.forEach(function(genre) {
                let newGenre = new Genre(genre);
                genres.push(newGenre);
            });
            this.genres = genres;
        }
        
        formatIndex() {
            const baseUrl = 'http://localhost:3000';
            let vinylHtml = `<tr id='vinyl_${this.id}'>`;
            vinylHtml += `<th scope="row"><a href="${baseUrl}/artists/${this.artistId}">${this['artistName']}</a></th>`;
            vinylHtml += `<th scope="row"><a href="${baseUrl}/vinyls/${this['id']}">${this['title']}</a></th>`;
            vinylHtml += '<th scope="row">' + this.formatPrice() +'</th>';
            vinylHtml += '<th scope="row">' + this['inventory'] +'</th>';
            vinylHtml += '<th scope="row">' + this.formatForSale() +'</th>';
            vinylHtml += `<th scope="row"><a href="${baseUrl}/vinyls/${this.id}/edit">Edit</a></th>`;
            vinylHtml += `<th scope="row"><a href="#" id=${this.id} class="delete_vinyl">Delete</a></th>`;
            vinylHtml += '</tr>';
            return vinylHtml;
        }
    
        formatPrice() {
            return `$${this['price']}`;
        }
    
        formatForSale() {
            return (this.forSale === true) ? "y" : "n";
        }
    };

    class Genre {
        constructor(genre) {
            this.id = genre.id;
            this.name = genre.name;
        }
        formatItem() {
            let genreHtml = `<li class="list-group-item">${this.name}</li>`
            return genreHtml;
        }
    };

}