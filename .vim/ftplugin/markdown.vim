if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

setlocal spell

syntax match NoSpellHttp 'http://\S*' contains=@NoSpell
syntax match NoSpellHttps 'https://\S*' contains=@NoSpell

