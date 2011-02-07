helpers do
	def create_controller name
		name.capitalize!
		require 'controllers/'+name
		eval(name).new
	end

  def css file
    if File.extname(file) == '.css'
      web_file = file
    else
      web_file = file+'.css'
      file += '.less'
    end
    "/css/#{web_file}?" + File.mtime(File.join(settings.public, "css", "#{file}")).to_i.to_s
  end

  def js file
    "/js/#{file}.js?" + File.mtime(File.join(settings.public, "js", "#{file}.js")).to_i.to_s
  end

	def header subtitle
			haml '%h1
  %img{:src => "/img/icon.jpg", :align => "top"}/
  %a{:href => "/"} Alexandria Web
%h2 '+subtitle+"
#menu
  %a{:href => '/list/table'} Table list
  |
  %a{:href => '/list/thumbnails'} Thumbnails list"
	end

  def book_link book
    haml "%a{:href => '/book/#{book.library}/#{book.ident.to_s}'}> #{book.title}"
  end
end