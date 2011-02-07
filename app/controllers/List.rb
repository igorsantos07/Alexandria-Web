require 'models/Book'

class List

  def table library=nil
    data = {:title => 'Table listing'}
		data[:title] << " of \"#{library}\"" unless library == nil

    @books = load_library library
		data[:books] = @books

		data
  end

  def thumbnails library=nil
    data = {:title => 'Table listing'}
		data[:title] << " of \"#{library}\"" unless library == nil

    @books = load_library library
		data[:books] = @books

		data
  end

###########
  private #
###########

  def load_library name=nil
    Model_Book.new.get_all_books
  end

end