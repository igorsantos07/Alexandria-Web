class Alexandria::Book
  attr_reader :cover, :web_cover, :lib_obj

  @@libraries = {}

  def cover?
    set_extended_data if @cover.nil?
    File.exists? @cover
  end

  private
  def set_extended_data
    @@libraries[@library] = Alexandria::Library::load(@library) if @@libraries[@library].nil?
    @lib_obj = @@libraries[@library]
    @cover = @lib_obj.cover self

    path = @cover.split '/'
    @web_cover = '/cover/'+@library+'/'+path[path.length-1]
  end
end

class Model_Book

	def get_all_books reduced_notes=false
		libraries = Array.new
		Dir.entries(settings.folder).each do |dir|
			libraries << dir unless dir.chars.next == '.'
		end

		@books = Array.new
		libraries.each do |lib|
			Alexandria::Library::load(lib).each do |book|
				book.notes = book.notes[0..250] << '...' if reduced_notes and !book.notes.empty? and book.notes.size > 250
				puts book.notes
				@books << book
			end
		end

		@books
	end

	def get_all_wishlist reduced_notes=false
		get_all_books reduced_notes unless instance_variable_defined? :@books
		return @wishlist if instance_variable_defined? :@wishlist

		@wishlist = Array.new
		@books.each do |book|
			@wishlist << book if !book.own? and book.want?
		end

		@wishlist
	end

	def get_all_read reduced_notes=false
		get_all_books reduced_notes unless instance_variable_defined? :@books
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

  def get_data library, ident
    book = YAML.load_file File.join settings.folder, library, ident+'.yaml'
    book.library = library

    return book
  end

end