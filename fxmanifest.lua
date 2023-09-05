fx_version 'cerulean'

description 'AdrenCAD CAD Framework'
author 'AdrenCAD Development Team'
version '1.0.0'
lua54 'yes'

games {
  'gta5'
}

ui_page 'web/build/index.html'

server_script 'libs/**/**.js'

shared_script 'config.lua'
server_script 'convars.lua'

server_script 'server/logger.js'

server_script 'API/index.js'
server_script 'API/routes/**/**.js'

server_script 'server/integrations.js'
-- server_script 'integrations/**/**.js'

client_script 'libs/sitdown/list.lua'
client_script 'libs/sitdown/client.lua'

server_script 'server/index.lua'
server_script 'server/socket.js'
server_script 'server/heartbeat.js'
server_script 'server/server.lua'
server_script 'server/auth.lua'
server_script 'server/identifiers.lua'
server_script 'server/mdt.lua'
server_script 'server/plugins.js'

client_script 'client/utils.lua'
client_script 'client/client.lua'

client_script 'client/**/*'

files {
	'web/build/index.html',
	'web/build/**/*',
}