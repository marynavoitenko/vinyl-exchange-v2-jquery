$(function() {
    let url = window.location.href;
    let id = url.split("/").pop();

    $.ajax({
        type: 'GET',
        url: `/artists/${id}.json`
    }).done(function(data) {
        let newArtist = new Artist(data);
        $('#vinyls_table').html("");
        for (let i = 0; i < newArtist.vinyls.length; i++) {
            let div_html = newArtist.vinyls[i].formatIndex(newArtist.id, newArtist.name);
            $('#vinyls_table').append(div_html);
        };
    });

    function Artist(artist) {
        this.id = artist.id;
        this.name = artist.name;
        this.vinyls = [];
        let vinyls = this.vinyls;
        artist.vinyls.forEach(function(vinyl) {
            let newVinyl = new Vinyl(vinyl);
            vinyls.push(newVinyl);
        });
        this.vinyls = vinyls;
    }

    function Vinyl(vinyl) {
        this.id = vinyl.id;
        this.title = vinyl.title;
        this.price = vinyl.price;
        this.inventory = vinyl.inventory;
        this.for_sale = vinyl.for_sale;
    }


    Vinyl.prototype.formatIndex = function(artist_id, artist_name) {
        let base_url = 'http://localhost:3000';
        let vinyl_html = `<tr id='vinyl_${this.id}'>`;
        vinyl_html += `<th scope="row"><a href="${base_url}/artists/${artist_id}">${artist_name}</a></th>`;
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