class Model_Book

	def get_books
		libraries = Array.new
		Dir.entries(settings.folder).each do |dir|
			libraries << dir unless dir.chars.next == '.'
		end

		@books = Array.new
		libraries.each do |lib|
			Dir.entries(File.join settings.folder, lib).each do |file|
				file = File.join settings.folder, lib, file
				if File.extname(file) == '.yaml'
					data = YAML.load_file(file).ivars
					data.merge!({
							'mtime' => File.mtime(file),
							'id' => data['saved_ident'],
							'read' => data['redd'],
							'read_when' => data['redd_when'],
						})

					@books << data
				end
			end
		end

		@books
	end

	def get_wishlist
		get_books unless instance_variable_defined? :@books
		return @wishlist if instance_variable_defined? :@wishlist

		@wishlist = Array.new
		@books.each do |book|
			@wishlist << book if !book['own'] and book['want']
		end

		@wishlist
	end

	def get_read
		get_books unless instance_variable_defined? :@books
		return @read if instance_variable_defined? :@read

		@read = Array.new
		@books.each do |book|
			@read << book if book['read']
		end

		@read
	end

	def get_summary
		{
			:all => get_books,
			:wishlist => get_wishlist,
			:read => get_read
		}
	end

end