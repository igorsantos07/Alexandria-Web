class Index

	def home
		require 'models/Book'
		Model_Book.new.get_summary
	end
end