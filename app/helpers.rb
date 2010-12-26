helpers do
	def create_controller name
		name.capitalize!
		require 'controllers/'+name
		eval(name).new
	end

  def css file
    "/css/#{file}.css?" + File.mtime(File.join(settings.public, "css", "#{file}.less")).to_i.to_s
  end

  def js file
    "/js/#{file}.js?" + File.mtime(File.join(settings.public, "js", "#{file}.js")).to_i.to_s
  end

	def header subtitle
			haml '%h1
	%img{:src => "/img/icon.jpg", :align => "top"}/
	%a{:href => "/"} Alexandria Web
%h2 '+subtitle
	end
end