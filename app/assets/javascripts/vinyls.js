$(function() {
    $('.my_vinyls').on('click', function() {
        $('.new_vinyl').hide();
        $.ajax({
            type: 'GET',
            url: '/vinyls/my_vinyls.json'
        }).done(function(data) {
            let div_html = '';
            $.each(data, function( index, value ) {
                let newVinyl = new Vinyl(value);
                div_html += newVinyl.formatIndex();
            });
        
            $('#vinyls_table').html(div_html);

            $('.delete_vinyl').click(function() {
                let id = $(this).attr("id");
                if (confirm('Are you sure?')) {
                    $.ajax({
                    type: 'DELETE',
                    url: `/vinyls/${id}`
                    }).done(function(data) {
                        $(`#vinyl_${id}`).delete();
                    });
                }
                
            });
            
            $('.add_new_vinyl').click(function(e) {
                e.preventDefault();
                $(".new_vinyl").show();
            });
            
            $('form').submit(function(e) {
                e.preventDefault();
                let values = $(this).serialize();
                console.log(values);
                $.ajax({
                    type: 'POST',
                    data: values, 
                    url: '/vinyls/',
                    dataType: 'json'
                }).done(function(data) {
                    console.log(data);
                    let newVinyl = new Vinyl(data);
                    div_html = newVinyl.formatIndex();
                    $('#vinyls_table').append(div_html);
                    $('.new_vinyl').hide();
                }).error(function(e) {
                    let err = JSON.parse(e.responseText);
                    console.log(err.errors);
                    $('.alert').show();
                    let error_html = "";
                    $.each(err.errors, function(index, value) {
                        error_html += value + '<br>';
                    });
                    $('.alert').html(error_html);
                });
            });
        });
    });
    

    

    // VINYL SHOW

    $(".vinyl_title").on('click', function() {
        // let id = $(this).attr('id');

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
    });


    // not updating url on "next" => need to save initial vinyl id
    var url = window.location.href;
    var id = url.split("/").pop();
    $("#current_vinyl_id").html(id);

    $('.next').click(function() {

        let curr_id = $("#current_vinyl_id").html();

        $.ajax({
            type: 'GET',
            url: `/vinyls/${curr_id}/next`
        }).done(function(data) {
            let newVinyl = new Vinyl(data);
            let div_html = newVinyl.formatIndex();
            $('#vinyls_table').html(div_html);
            $("#current_vinyl_id").html(newVinyl.id);
        });
    });

    


    function Vinyl(vinyl) {
        this.id = vinyl.id;
        this.title = vinyl.title;
        this.price = vinyl.price;
        this.inventory = vinyl.inventory;
        this.for_sale = vinyl.for_sale;
        this.artist_id = vinyl.artist.id;
        this.artist_name = vinyl.artist.name;
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

});