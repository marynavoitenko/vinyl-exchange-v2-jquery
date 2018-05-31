$( document ).on('turbolinks:load', function() {
    console.log('It works on each visit!');
    attachEventListeners();
});

function attachEventListeners() {
    // GET vinyls index via ajax and display
    $('.vinyls_index').on('click', getVinylsIndex);
    // GET single vinyl and display
    $(getVinyl);
    // GET next vinyl and display without page refresh
    $('.next').click( loadNextVinyl );
    
    $('.load_genres').click( loadGenres );

    function getVinylsIndex() {
        $.ajax({
            type: 'GET',
            url: '/vinyls/my_vinyls.json'
        }).done(function(data) {
            $('.vinyls_index').hide();
            let div_html = '';
            $.each(data, function( index, value ) {
                let newVinyl = new Vinyl(value);
                div_html += newVinyl.formatIndex();
            });
        
            $('#vinyls_table').html(div_html);
    
            $('.delete_vinyl').click( deleteVinyl ); 
        });
    };
    
    function deleteVinyl() {
        let id = $(this).attr("id");
        if (confirm('Are you sure you want to delete this vinyl?')) {
            $.ajax({
            type: 'DELETE',
            url: `/vinyls/${id}`
            }).done(function(data) {
                $(`#vinyl_${id}`).delete();
            });
        }
        return false;
    };

    function getVinyl() {
        let url = window.location.href;
        let id = url.split("/").pop();
        $("#current_vinyl_id").html(id);
    
        $.ajax({
            type: 'GET',
            url: `/vinyls/${id}.json`
        }).done(function(data) {
            let newVinyl = new Vinyl(data);
            let div_html = newVinyl.formatIndex();
            $('#vinyls_table').html(div_html);
        }); 
    };
    
    function loadNextVinyl() {
        let curr_id = $("#current_vinyl_id").html();
        $('#genres').hide();
        $.ajax({
            type: 'GET',
            url: `/vinyls/${curr_id}/next`
        }).done(function(data) {
            let newVinyl = new Vinyl(data);
            let div_html = newVinyl.formatIndex();
            $('#vinyls_table').html(div_html);
            $("#current_vinyl_id").html(newVinyl.id);
        });
    };    

    function loadGenres() {
        $('#genres').show();
        let vinyl_id = $("#current_vinyl_id").html();
        $.ajax({
            type: 'GET',
            url: `/vinyls/${vinyl_id}.json`
        }).done(function(data) {
            let newVinyl = new Vinyl(data);
            $('#genres').html("");
            if (newVinyl.genres.length > 0) {
                let genre_html = '<ul class="list-group">';
                for (let i = 0; i < newVinyl.genres.length; i++) {
                    let genre_html = newVinyl.genres[i].formatItem();
                    $('#genres').append(genre_html);
                };
                genre_html += '</ul>';
            } else {
                $('#genres').html('Vinyl has no genres.');
            }
            
        });
    }

// $(function() {
//     $('.new_vinyl').hide();
//     
        
//         $('.new_vinyl_button').click(function(e) {
//             e.preventDefault();
//             $(".new_vinyl").show();
//         });
        
//         $('form').submit(function(e) {
//             e.preventDefault();
//             let values = $(this).serialize();
//             console.log(values);
//             $.ajax({
//                 type: 'POST',
//                 data: values, 
//                 url: '/vinyls/',
//                 dataType: 'json'
//             }).done(function(data) {
//                 console.log(data);
//                 let newVinyl = new Vinyl(data);
//                 div_html = newVinyl.formatIndex();
//                 $('#vinyls_table').append(div_html);
//                 $('.new_vinyl').hide();
//             }).error(function(e) {
//                 let err = JSON.parse(e.responseText);
//                 console.log(err.errors);
//                 $('.alert').show();
//                 let error_html = "";
//                 $.each(err.errors, function(index, value) {
//                     error_html += value + '<br>';
//                 });
//                 $('.alert').html(error_html);
//             });
//         });
        
//     });

    

    function Vinyl(vinyl) {
        this.id = vinyl.id;
        this.title = vinyl.title;
        this.price = vinyl.price;
        this.inventory = vinyl.inventory;
        this.for_sale = vinyl.for_sale;
        this.artist_id = vinyl.artist.id;
        this.artist_name = vinyl.artist.name;
        this.genres = [];
        let genres = this.genres;
        vinyl.genres.forEach(function(genre) {
            let newGenre = new Genre(genre);
            genres.push(newGenre);
        });
        this.genres = genres;
    }

    function Genre(genre) {
        this.id = genre.id;
        this.name = genre.name;
    }

    Vinyl.prototype.formatIndex = function() {
        let base_url = 'http://localhost:3000';
        let vinyl_html = `<tr id='vinyl_${this.id}'>`;
        vinyl_html += `<th scope="row"><a href="${base_url}/artists/${this.artist_id}">${this['artist_name']}</a></th>`;
        vinyl_html += `<th scope="row"><a href="${base_url}/vinyls/${this['id']}">${this['title']}</a></th>`;
        vinyl_html += '<th scope="row">' + this.formatPrice() +'</th>';
        vinyl_html += '<th scope="row">' + this['inventory'] +'</th>';
        vinyl_html += '<th scope="row">' + this.formatForSale() +'</th>';
        vinyl_html += `<th scope="row"><a href="${base_url}/vinyls/${this.id}/edit">Edit</a></th>`;
        vinyl_html += `<th scope="row"><a href="#" id=${this.id} class="delete_vinyl">Delete</a></th>`;
        vinyl_html += '</tr>';
        return vinyl_html;
    }

    Vinyl.prototype.formatPrice = function() {
        return `$${this['price']}`;
    }

    Vinyl.prototype.formatForSale = function() {
        return (this.for_sale === true) ? "y" : "n";
    }

    Genre.prototype.formatItem = function() {
        let genre_html = `<li class="list-group-item">${this.name}</li>`
        return genre_html;
    }

}