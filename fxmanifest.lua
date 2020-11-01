-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Lucian Fialho'
description 'Discord Webhook to log commands'
version '1.0.0'

server_scripts {
    'config.lua',
    'server/commandChecker.lua',
    'server/webhook.lua',
    'server/main.lua'
}

server_only 'yes'