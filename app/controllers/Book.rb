class Book

	def home library, book_id
		require 'models/Book'
    Model_Book.new.get_data library, book_id
  end
  
end