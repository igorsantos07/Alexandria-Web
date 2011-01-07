class Model_Book

	def get_all_books
		libraries = Array.new
		Dir.entries(settings.folder).each do |dir|
			libraries << dir unless dir.chars.next == '.'
		end

		@books = Array.new
		libraries.each do |lib|
			Dir.entries(File.join(settings.folder, lib)).each do |file|
				file = File.join settings.folder, lib, file
				@books << get_data_from_yaml(file) if File.extname(file) == '.yaml'
			end
		end

		@books
	end

	def get_all_wishlist
		get_all_books unless instance_variable_defined? :@books
		return @wishlist if instance_variable_defined? :@wishlist

		@wishlist = Array.new
		@books.each do |book|
			@wishlist << book if !book['own'] and book['want']
		end

		@wishlist
	end

	def get_all_read
		get_all_books unless instance_variable_defined? :@books
		return @read if instance_variable_defined? :@read

		@read = Array.new
		@books.each do |book|
			@read << book if book['read']
		end

		@read
	end

	def get_summary
		{
			:all => get_all_books,
			:wishlist => get_all_wishlist,
			:read => get_all_read
		}
	end

  def get_data library, id
    get_data_from_yaml File.join settings.folder, library, id+'.yaml'
  end

  def get_data_from_yaml file
    data = YAML.load_file(file).ivars

    path = file.split('/')
    library = path[path.length - 2]
    cover = file.sub('.yaml', '.cover')
    if (data['isbn'] == nil)
      cover.sub! library+'/', library+'/g'
    end

    data.merge!({
        'mtime' => File.mtime(file),
        'id' => data['saved_ident'],
        'read' => data['redd'],
        'read_when' => data['redd_when'],
        'library' => library,
        'cover' => cover,
        'cover?' => File.file?(cover)
      })

    data.each do |k,v| puts "#{k}: #{v}\n" end

    return data
  end

end