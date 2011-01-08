class Alexandria::Book
  attr_reader :cover, :web_cover

  def cover
    lib = Alexandria::Library::load(@library)
    lib.cover(self)
  end

  def cover?
    File.exists? cover
  end

  def web_cover
    path = cover.split '/'
    '/cover/'+library+'/'+path[path.length-1]
  end
end

class Model_Book

	def get_all_books
		libraries = Array.new
		Dir.entries(settings.folder).each do |dir|
			libraries << dir unless dir.chars.next == '.'
		end

		@books = Array.new
		libraries.each { |lib| Alexandria::Library::load(lib).each { |book| @books << book } }

		@books
	end

	def get_all_wishlist
		get_all_books unless instance_variable_defined? :@books
		return @wishlist if instance_variable_defined? :@wishlist

		@wishlist = Array.new
		@books.each do |book|
			@wishlist << book if !book.own? and book.want?
		end

		@wishlist
	end

	def get_all_read
		get_all_books unless instance_variable_defined? :@books
		return @read if instance_variable_defined? :@read

		@read = Array.new
		@books.each do |book|
			@read << book if book.redd?
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
    book = YAML.load_file File.join settings.folder, library, id+'.yaml'
    book.library = library

    return book
  end

end