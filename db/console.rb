require("pry")
require_relative("../models/album.rb")
require_relative("../models/artist.rb")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Beyond'})
artist2 = Artist.new({'name' => 'Perfume'})
artist1.save()
artist2.save()
artist1.name = "Victoria"
artist1.update()

album1 = Album.new({'genre' => 'Rock', 'artist_id' => artist1.id})
album2 = Album.new({'genre' => 'Pop', 'artist_id' => artist2.id})

album1.save()
album2.save()
album2.artist_id = artist1.id
album2.update()

# Album.delete(album1.id)
# Artist.delete(artist1.id)

binding.pry
nil
