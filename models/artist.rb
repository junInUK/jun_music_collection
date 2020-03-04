require('pg')
require_relative('../db/sql_runner.rb')
require_relative('album.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(artist)
    @id = artist['id'].to_i if artist['id']
    @name = artist['name']
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    result = SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO artists(name)
    VALUES ($1) RETURNING id"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def self.all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artist.new(artist)}
  end

  def list_albums
    albums = Album.get_albums_by_artist_id(@id)
    return albums     
  end

  def update
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    Album.delete_by_artist(id)
    sql = "DELETE FROM artists WHERE id = $1"
    value = [id]
    SqlRunner.run(sql,value)
  end

  def self.get_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    value = [id]
    artist = SqlRunner.run(sql,value).first()
    return Artist.new(artist)
  end

end
