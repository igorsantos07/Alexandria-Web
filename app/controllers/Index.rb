class Index

	def get_books
		require 'models/Book'
		Model_Book.get_all
	end

	def home
		puts 'aushduashudasasasasahsa'
		get_books

		{
			:recent => [
				{:isbn => 56494121, :title => 'Rangers 4'},
				{:isbn => 56494121, :title => 'Sherlock Holmes e o Jogador Perdido'}
			],
			:wishlist => [
				{:isbn => 56494121, :title => 'Apartamento 41'},
				{:isbn => 56494121, :title => 'O terceiro travesseiro'},
				{:isbn => 56494121, :title => 'Cidade dos Ossos'},
				{:isbn => 56494121, :title => 'Estação Polar'},
				{:isbn => 56494121, :title => 'O Senhor da Chuva'}
			],
			:read => [
				{:isbn => 56494121, :title => 'Escaldado em água fria'},
				{:isbn => 56494121, :title => 'Sherlock Holmes e o Jogador Perdido'},
				{:isbn => 56494121, :title => 'Nunca desista dos seus sonhos'},
				{:isbn => 56494121, :title => 'A Batalha do Apocalipse'}
			]
		}
	end
end

Index.new.get_books