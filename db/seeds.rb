# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first

require 'open-uri'
require 'json'

puts 'Cleaning database...'
Movie.destroy_all
puts 'Database cleaned!'

url = 'https://tmdb.lewagon.com/movie/top_rated'

response = URI.open(url).read
movies = JSON.parse(response)['results'] 
movies.each do |movie|
    puts "Creating #{movie['title']}..."
    poster_url_base = "https://image.tmdb.org/t/p/original"
    Movie.create(
        title: movie['title'], 
        overview: movie['overview'], 
        poster_url: "#{poster_url_base}#{movie['poster_path']}",
        rating: movie['vote_average']
    )
end