class Model_Book

	def Model_Book.get_all
		libraries = Array.new
		Dir.entries(settings.folder).each do |dir|
			libraries << dir unless dir.chars.next == '.'
		end

		libraries.each do |file|
			puts Dir.entries(FOLDER+lib) if File.extname(file) == '.yaml'
		end
	end

end