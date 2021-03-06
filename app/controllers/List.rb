require 'models/Book'

class List

  def table library=nil
    data = {:title => 'Table listing'}
		data[:title] << " of \"#{library}\"" unless library == nil

    @books = load_library library, :reduced_notes
		data[:books] = @books

		data
  end

  def thumbnails library=nil
    data = {:title => 'Thumbnail listing'}
		data[:title] << " of \"#{library}\"" unless library == nil

    @books = load_library library
		data[:books] = @books

		data
  end

###########
  private #
###########

  def load_library name=nil, reduced_notes=false, order_by='title'
    lib = Model_Book.new.get_all_books reduced_notes
		puts lib.class
		lib.sort! {|a,b| eval("a.#{order_by}") <=> eval("b.#{order_by}")}
		lib
  end
end
