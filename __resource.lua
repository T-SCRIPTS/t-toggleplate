resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"
lua54 'yes'

shared_script '@ox_lib/init.lua'

ui_page 'h.html'

client_scripts {
    'c.lua'
} 

files {
    'h.html'
}

export "startUI"

dependencies {
  'es_extended',
  'ox_lib',
  't_irtikilpi'
}
