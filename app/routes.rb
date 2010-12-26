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

##### "REAL" ROUTES #####

get '/' do
	@data = create_controller('Index').home
	haml :index
end

get '/about/?'	do haml :about end

#get '/list/'

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