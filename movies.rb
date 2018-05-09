fileName = ARGV[0] || './movies.txt'
if !File.file?(fileName)
    abort "No such file"
end

Hash_Movies = IO.read(fileName).split("\n").map { |movie|
    [:link, :title, :year, :country, :date, :zhanre, :time, :rating, :director, :actors].zip(movie.split("|")).to_h
}

def prettyMovies(listMovies)
    listMovies.map{|el| "#{el[:title]} (#{el[:date]}; #{el[:zhanre]}) - #{el[:time]}"}
end

Long_Movies = Hash_Movies.sort_by{|hsh| hsh[:time].split(' ')[0].to_i}.last(5)
Comedy_Movies = Hash_Movies.select{|el| el[:zhanre].include? "Comedy"}.sort_by{|hsh| hsh[:date]}.first(10)
Count_Movies_Not_USA = Hash_Movies.reject{|el| el[:country].include? "USA"}.length
Directors = Hash_Movies.map{|el| el[:director]}.uniq.sort_by{|el| el.split(' ').last(1)}

puts '************************************'
puts '5 the longest movies:'
puts prettyMovies(Long_Movies)
puts '************************************'
puts '10 Comedies:'
puts prettyMovies(Comedy_Movies)
puts '************************************'
puts 'Directors:'
puts Directors
puts '************************************'
puts 'Count movies, made not in USA:'
puts Count_Movies_Not_USA
puts '************************************'
