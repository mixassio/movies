fileName = ARGV[0] || './movies.txt'

if !File.file?(fileName)
    abort "No such file"
end

config = IO.read(fileName)

selectMovies = config.split("\n").select { |el| el.split("|")[1].include? "Max" }

puts selectMovies.map { |el| [el.split("|")[1], '*' * (el.split("|")[7].to_f * 10 - 80)].join(' ')}