require 'CSV'
require 'ostruct'

file_name = ARGV[0] || './movies.txt'
if !File.file?(file_name)
    abort "No such file"
end

hash_keys = %i[link title year country date zhanre time rating director actors]

movies = CSV.readlines(file_name, :col_sep => '|', :headers => hash_keys).map{|movie|
    OpenStruct.new(movie.to_h)
}

long_movies = movies.sort_by{|hsh| hsh.time.split(' ')[0].to_i}.last(5)
comedy_movies = movies.select{|el| el.zhanre.include? "Comedy"}.sort_by{|hsh| hsh.date}.first(10)
count_movies_not_USA = movies.reject{|el| el.country.include? "USA"}.length
directors = movies.map(&:director).uniq.sort_by{|el| el.split(' ').last(1)}

months = movies.map(&:date).select{|el| el.length == 10}.map{|el| Date.parse(el).mon}
count_by_month = months.group_by(&:itself).sort_by(&:first).map{|k, v| "in #{Date::MONTHNAMES[k]} were made #{v.length} movies"}

def prettyMovies(listMovies)
    listMovies.map{|el| "#{el.title} (#{el.date}; #{el.zhanre}) - #{el.time}"}
end

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
puts 'Count movies, maded by month:'
puts count_by_month
puts '************************************'
