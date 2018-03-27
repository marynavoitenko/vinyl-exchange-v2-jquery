# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.find(1)

genre1 = Genre.find_or_create_by(name: "Jazz")

artist1 = Artist.find_or_create_by(name: "Surly")
vinyl1 = user.vinyls.new(title: "Trip To Warsaw", price: 19)
vinyl1.artist = artist1
vinyl1.genres << genre1
vinyl1.save

artist2 = Artist.find_or_create_by(name: "Miles Davis")
vinyl2 = user.vinyls.new(title: "Album Classics", price: 16)
vinyl2.artist = artist2
vinyl2.genres << genre1
vinyl2.save

genre2 = Genre.find_or_create_by(name: "Disco")

artist3 = Artist.find_or_create_by(name: "A Taste Of Honey")
vinyl3 = user.vinyls.new(title: "Boogie Oogie Oogie", price: 12)
vinyl3.artist = artist3
vinyl3.genres << genre2
vinyl3.save

artist4 = Artist.find_or_create_by(name: "Marta Acuna")
vinyl4 = user.vinyls.new(title: "Dance Dance Dance", price: 16)
vinyl4.artist = artist4
vinyl4.genres << genre2
vinyl4.save

genre3 = Genre.find_or_create_by(name: "House")

artist5 = Artist.find_or_create_by(name: "Kerri Chandler")
vinyl5 = user.vinyls.new(title: "Rain", price: 10)
vinyl5.artist = artist5
vinyl5.genres << genre3
vinyl5.save

artist6 = Artist.find_or_create_by(name: "Toto Chiavetta")
vinyl6 = user.vinyls.new(title: "Impermanence", price: 10)
vinyl6.artist = artist6
vinyl6.genres << genre3
vinyl6.save
