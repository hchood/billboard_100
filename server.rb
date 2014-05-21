require 'sinatra'
require 'csv'
require 'pry'

def read_songs_from(csv)
  songs = []

  CSV.foreach(csv, headers: true) do |row|
    song = {
      artist: row["artist"],
      title: row["song"],
      album: row["album"],
      position: row["position"]
    }
    songs << song
  end

  songs
end

def find_song(title)
  songs = read_songs_from('billboard_100.csv')

  song_to_find = nil

  songs.each do |song|
    song_to_find = song if song[:title].downcase == title.downcase
  end

  song_to_find
end

get '/songs' do
  @songs = read_songs_from('billboard_100.csv')
  erb :index
end

get '/songs/:title' do
  @song = find_song(params[:title])
  # binding.pry
  erb :show
end
