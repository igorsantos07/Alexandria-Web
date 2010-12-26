class Index

	def home
		require 'models/Book'
		Model_Book.get_summary
	end
end