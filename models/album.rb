require('pg')

class Album

  attr_reader :id, :genre
  attr_accessor :artist_id

  def initialize(album)
    @id = album['id'].to_i if album['id']
    @genre = album['genre']
    @artist_id = album['artist_id']
  end

  def save()
    sql = "INSERT INTO albums(genre, artist_id)
    VALUES ($1, $2) RETURNING id"
    values = [@genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end


  def self.delete_all
    sql = "DELETE FROM albums"
    result = SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

  def get_artist
    return Artist.get_by_id(@artist_id)
  end

  def self.get_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    value = [id]
    album = SqlRunner.run(sql,value).first()
    return Album.new(album)
  end

  def self.get_albums_by_artist_id(artist_id)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    value = [artist_id]
    albums = SqlRunner.run(sql,value)
    return albums.map{|album| Album.new(album)}
  end

  def update
    sql = "UPDATE albums SET (genre,artist_id) = ($1,$2) WHERE id = $3"
    values = [@genre,@artist_id,@id]
    SqlRunner.run(sql,values)
  end

  def self.delete(id)
    sql = "DELETE FROM albums where id = $1"
    value = [id]
    SqlRunner.run(sql,value)
  end

  def self.delete_by_artist(artist_id)
    sql = "DELETE FROM albums WHERE artist_id = $1"
    value = [artist_id]
    SqlRunner.run(sql,value)
  end

end
