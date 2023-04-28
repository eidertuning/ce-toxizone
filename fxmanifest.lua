fx_version 'cerulean'
game 'gta5'

description 'ce-toxizone'

lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'shared/config.lua',
}

client_scripts {
    'client/main.lua',
    'client/utils.lua'
}

server_scripts {
    'server/main.lua',
}

dependencies {
    'es_extended',
    'ox_inventory',
    'ox_lib',
}
