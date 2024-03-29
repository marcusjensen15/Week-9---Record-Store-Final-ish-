class Song
  attr_reader :id
  attr_accessor :name, :album_id

  @@songs = {}
  @@total_rows = 0

  def initialize(name, album_id, id)
    @name = name
    @album_id = album_id
    @id = id || @@total_rows += 1

  end

  def self.all
    @@songs.values()
  end

  def self.sort
    @@songs.values.sort_by { | val| val.name}
  end

  def save
    @@songs[self.id] = Song.new(self.name, self.album_id, self.id)
  end

  def ==(song_to_compare)
    self.name == song_to_compare.name() && (self.album_id() == song_to_compare.album_id())
  end

  def self.clear
    @@songs = {}
    @@total_rows = 0
  end

  def update(name)
    @name = name
    @@songs[self.id] = Song.new(self.name, self.album_id, self.id)
  end

  def self.find(id)
    @@songs[id]
  end

  def self.search(type, search)
    @@songs.values.select{ |song|
      song.send(type) =~ /#{search}/i
    }.sort{ |x,y| x.name <=> y.name }
  end

  def delete
    @@songs.delete(self.id)
  end

  def self.find_by_album(album_id)
    @@songs.values.select{ |song| song.album_id == album_id }
  end

end
