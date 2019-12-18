require './lib/song'

class Album
  attr_reader :id, :name, :year, :artist, :genre

  @@albums = {}
  @@total_rows = 0
  @@sold_albums = {}

  def initialize(name, id, year, genre, artist)
    @name = name
    @id = id || @@total_rows += 1
    @year = year
    @genre = genre
    @artist = artist
    @sold = false
  end

  def self.all
    @@albums.values().sort_by { | val| val.name}
  end


  def self.sold_albums
    @@sold_albums.values()
  end

  def sold
    @@sold_albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist)
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist)
  end

  def ==(album_to_compare)
    self.name == album_to_compare.name()
  end

  def update(name)
    @name = name
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def self.search(type, search)
    @@albums.values.select{ |album|
      album.send(type) =~ /#{search}/i
    }.sort{ |x,y| x.name <=> y.name }
  end

  def delete
    @@albums.delete(self.id)
  end

  def get_songs
    Song.find_by_album(self.id)
  end

end
