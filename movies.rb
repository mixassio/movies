fileName = (!ARGV.empty? && File.file?(ARGV[0])) ? ARGV[0] : './movies.txt'
config = IO.read(fileName)

stars = -> (num) { '*' * (num.to_f * 10 - 80) }

selectMovies = config.split("\n").select { |el| el.split("|")[1].include? "Max" }
puts selectMovies.map { |el| [el.split("|")[1], stars.call(el.split("|")[7])].join(' ')}