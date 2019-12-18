require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')

get('/test/') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/') do
  @albums = Album.all
  @sold = Album.sold_albums
  erb(:albums)
end

get('/albums') do
  @albums = Album.all
  @sold = Album.sold_albums
  erb(:albums)
end

post('/albums/search') do
  @albums = Album.search(params[:type], params[:search])
  @sold = Album.sold_albums
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

post('/albums') do
  name = params[:album_name]
  year = params[:year]
  artist = params[:artist]
  genre = params[:genre]
  album = Album.new(name, nil, year, genre, artist)
  album.save()
  @albums = Album.all
  @sold = Album.sold_albums
  erb(:albums)
end

patch('/albums/:id/sold') do
  @album = Album.find(params[:id].to_i())
  @album.sold
  @albums = Album.all
  @sold = Album.sold_albums
  erb(:albums)
end

get('/update/:id') do
  @albums = Album.all
  @sold = Album.sold_albums
  erb(:albums)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @album.sold
  @albums = Album.all
  @sold = Album.sold_albums
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  @sold = Album.sold_albums
  erb(:albums)
end

#### Routing for songs below

get('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  @songs = @album.get_songs
  erb(:songs)
end

get('/albums/:id/songs/new') do
  @album = Album.find(params[:id].to_i())
  erb(:new_song)
end

post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil)
  song.save
  @songs = @album.get_songs
  erb(:songs)
end

get('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

get('/albums/:id/songs/:song_id/edit') do
  @album = Album.find(params[:id].to_i())
  @song = Song.find(params[:song_id].to_i())
  erb(:edit_song)
end

delete('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.delete
  @songs = @album.get_songs
  erb(:songs)
end

patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name])
  @songs = @album.get_songs
  erb(:songs)
end
