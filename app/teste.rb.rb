require 'controllers/Index'
data = Index.new.home
data[:recent].each do |book|
	puts book[:isbn].to_s+': '+book[:title]
end