fileName = ARGV[0] || './movies.txt'
if !File.file?(fileName)
    abort "No such file"
end
config = IO.read(fileName)
Movies = config.split("\n")
HashMovies = Movies.map { |movie|
    {
        :link => movie.split("|")[0],
        :title => movie.split("|")[1],
        :year => movie.split("|")[2],
        :country => movie.split("|")[3],
        :date => movie.split("|")[4],
        :zhanre => movie.split("|")[5],
        :time => movie.split("|")[6],
        :rating => movie.split("|")[7],
        :director => movie.split("|")[8],
        :actors => movie.split("|")[9],
    }
}

def prettyMovies(listMovies)
    listMovies.map{|el| "#{el[:title]} (#{el[:date]}; #{el[:zhanre]}) - #{el[:time]}"}
end

longMovies = HashMovies.sort_by{|hsh| hsh[:time].split(' ')[0].to_i}.last(5)
comedyMovies = HashMovies.select{|el| el[:zhanre].include? "Comedy"}.sort_by{|hsh| hsh[:date]}[0,10]
countMoviesNotUSA = HashMovies.select{|el| !el[:country].include? "USA"}.count
directors = HashMovies.map{|el| el[:director]}.uniq.sort_by{|el| el.split(' ')[-1]}

puts '************************************'
puts '5 the longest movies:'
puts prettyMovies(longMovies)
puts '************************************'
puts '10 Comedies:'
puts prettyMovies(comedyMovies)
puts '************************************'
puts 'Directors:'
puts directors
puts '************************************'
puts 'Count movies, made not in USA:'
puts countMoviesNotUSA
puts '************************************'