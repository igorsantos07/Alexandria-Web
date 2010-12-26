set({
	:public => File.dirname(__FILE__)+'/static',
	:folder => '/home/igoru/.alexandria',
	:logging => false,
})

configure do |app|
	app.also_reload 'controllers/*.rb', 'models/*.rb'
end