local lua_cache=$HOME/.lua.zsh

if [ ! -f $lua_cache ]; then
  if (( $+commands[lua] )); then
    if (($+LUA_USER)); then
      local saved_path=$(lua -e 'print(package.path)')
      local str="export LUA_PATH=\"$saved_path;$LUA_USER/?.lua\";"
      echo $str > $lua_cache
    fi
  fi
fi

if [ ! -f $lua_cache ]; then
  touch $lua_cache
fi

source $lua_cache

