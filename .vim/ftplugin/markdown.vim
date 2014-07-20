if exists("b:did_mdplugin")
  finish
endif

let b:did_mdplugin = 1

setlocal spell

syntax match NoSpellHttp 'http://\S*' contains=@NoSpell
syntax match NoSpellHttps 'https://\S*' contains=@NoSpell

