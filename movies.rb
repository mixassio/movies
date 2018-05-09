file_name = ARGV[0] || './movies.txt'
if !File.file?(file_name)
    abort "No such file"
end

hash_keys = %i[link title year country date zhanre time rating director actors]

hash_movies = IO.read(file_name).split("\n").map { |movie|
    hash_keys.zip(movie.split("|")).to_h
}

def prettyMovies(listMovies)
    listMovies.map{|el| "#{el[:title]} (#{el[:date]}; #{el[:zhanre]}) - #{el[:time]}"}
end

long_movies = hash_movies.sort_by{|hsh| hsh[:time].split(' ')[0].to_i}.last(5)
comedy_movies = hash_movies.select{|el| el[:zhanre].include? "Comedy"}.sort_by{|hsh| hsh[:date]}.first(10)
count_movies_not_USA = hash_movies.reject{|el| el[:country].include? "USA"}.length
directors = hash_movies.map{|el| el[:director]}.uniq.sort_by{|el| el.split(' ').last(1)}

puts '************************************'
puts '5 the longest movies:'
puts prettyMovies(long_movies)
puts '************************************'
puts '10 Comedies:'
puts prettyMovies(comedy_movies)
puts '************************************'
puts 'Directors:'
puts directors
puts '************************************'
puts 'Count movies, made not in USA:'
puts count_movies_not_USA
puts '************************************'
