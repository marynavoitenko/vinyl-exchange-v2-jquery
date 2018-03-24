# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
genre1 = Genre.create(name: "Jazz")

artist1 = Artist.create(name: "Surly")
vinyl1 = artist1.vinyls.create(title: "Trip To Warsaw", price: 19)
vinyl1.genres << genre1

artist2 = Artist.create(name: "Miles Davis")
vinyl2 = artist2.vinyls.create(title: "Album Classics", price: 16)
vinyl2.genres << genre1

genre2 = Genre.create(name: "Disco")

artist3 = Artist.create(name: "A Taste Of Honey")
vinyl3 = artist3.vinyls.create(title: "Boogie Oogie Oogie", price: 12)
vinyl3.genres << genre2

artist4 = Artist.create(name: "Marta Acuna")
vinyl4 = artist4.vinyls.create(title: "Dance Dance Dance", price: 16)
vinyl4.genres << genre2

genre3 = Genre.create(name: "House")

artist5 = Artist.create(name: "Kerri Chandler")
vinyl5 = artist5.vinyls.create(title: "Rain", price: 10)
vinyl5.genres << genre3

artist6 = Artist.create(name: "Toto Chiavetta")
vinyl6 = artist6.vinyls.create(title: "Impermanence", price: 10)
vinyl6.genres << genre3
