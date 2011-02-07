##### INFRASTRUCTURE ROUTES #####

get '/favicon.ico' do
	['png','gif','jpg','jpeg','ico'].each do | ext |
		filename = File.join(Sinatra::Application.public,'img', 'favicon.'+ext)
		if File.exist? filename
			$file = File.new filename
			break
		end
	end

	if $file.is_a? File
		response['Expires'] = (Time.now + 60*60*24*356*3).httpdate
		$file
	else
		404
	end
end

get '/css/*.css' do | file |
	response['Expires'] = (Time.now + 60*60*24*356*3).httpdate
	less eval(":'css/#{file}'")
end

get '/cover/:library/:name' do
  file = File.join settings.folder, params[:library], params[:name]
  return unless File.exists? file

  response['content-type'] = Alexandria::Library.jpeg?(file)? 'image/jpeg' : 'image/gif';
  File.new file
end

##### "REAL" ROUTES #####

get '/' do
	@data = create_controller('Index').home
	haml :index
end

get '/about/?'	do haml :about end

get '/list/:type/?' do
  listing = create_controller('List')
  @data = eval('listing.'+params[:type])
  haml ('lists/'+params[:type]).to_sym
end

get '/list/:type/:library/?' do
  listing = create_controller('List')
  @data = eval('listing.'+params[:type]+" '"+params[:library]+"'")
  haml ('lists/'+params[:type]).to_sym
end

get '/book/:library/:ident/?' do
	@data = create_controller('Book').home params[:library], params[:ident]
	haml :'books/index'
end

#get '/:controller/:action/*' do | c, a, param |
#	controller = create_controller(c)
#
#	if params[:splat].nil?
#		return eval "controller.#{a}"
#	else
#		return eval "controller.#{a} \"#{params[:splat][0].split('/').to_s}\""
#	end
#end
#
#get '/:controller/?' do | c |
#	create_controller(c).index
#end
