fx_version 'cerulean'
game 'gta5'
author 'Sleepy Rae'
lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'@ox_lib/init.lua',
	'utils.lua',
	'config/**.lua',
}


client_scripts {
	'client/**.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/**.lua',
}

dependencies {
	'ox_lib',
}