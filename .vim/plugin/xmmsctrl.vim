" Plugin: xmmsctrl.vim
" $Id: xmmsctrl.vim,v 1.38 2003/09/30 16:43:14 andrew Exp $
" Version: 0.2
" Purpose: simple XMMS control through 'smart' buffer
" Author: Andrew Rodionoff (arnost AT mail DOT ru)
"
" New in version 0.2:
" - Command line support, next/prev/pause/play/quit/shuffle/remove/song/volume
"   support, additional checks. Courtesy of Blake Matheny <bmatheny@purdue.edu>
"
" - Minor fixes and enhancements.
"
" Requires: Vim 6.2+, xmmsctrl 1.6+ by Alexandre David. Search it on xmms.org.
"
" Usage: just put it in $VIM/plugins/ folder
" type \xl to get a list of songs
" type \xr to remove the current song from the playlist
" type \xv to adjust the volume
" type \xn to move to the next song
" type \xp to move to the previous song
" type \xs to get the current song name
" type :Xmms help for full help
"
" Notes:
" - For tighter integration with XMMS, configure its songchange plugin
"   to run a command like this (join lines):
"   for n in `vim --serverlist`;
"   do vim --servername "$n" --remote-expr 'XMMS_SongChanged()' ; done
"
" - Use command similar to:
"   vim --remote-expr 'XMMS_OpenPlaylist(0)'
"   to popup playlist editor from shell or window manager menu
"
" Variables:
"   g:XMMS_TagEncoding -- set it to some valid encoding name if needed
"   g:XMMS_AutoSqueeze -- set to 1 if you want playlist to shrink/unshrink
"                         automatically (annoyingly) on window leave/enter
" Bugs:
" - AutoSqueeze shrinks all windows when plugin's buffer is the only window in
"   column and leaving. Is there a way to detect this situation and disable
"   it?
"
" TODO:
" - SideBar integration (?)

if v:version < 602
    finish
endif

if executable("xmmsctrl") < 1
  finish
endif

fun! s:Cmd_next()
  call system('xmmsctrl next')
  sleep 10m
  call s:Cmd_song()
endfun

fun! s:Cmd_prev()
  call system('xmmsctrl prev')
  sleep 10m
  call s:Cmd_song()
endfun

fun! s:Cmd_pause()
  call system('xmmsctrl pause')
endfun

fun! s:Cmd_play()
  call system('xmmsctrl play')
endfun

fun! s:Cmd_quit()
  call system('xmmsctrl quit')
endfun

fun! s:Cmd_shuffle()
  call system('xmmsctrl shuffle')
endfun

fun! s:Cmd_remove()
  call system('xmmsctrl remove')
endfun

fun! s:Cmd_stop()
  call system('xmmsctrl stop')
endfun

fun! s:Cmd_vol(volume)
  if a:volume == ""
    call s:Help()
  endif
  let l:cs = "xmmsctrl vol ".a:volume
  call system(l:cs)
endfun

fun! s:Cmd_song()
  let l:pos = substitute(system('xmmsctrl getpos'), "\n", "", "")
  let l:nam = substitute(system('xmmsctrl title'), "\n", "", "")
  let l:foowinwidth = &columns
  let l:retval = l:pos.": ".l:nam
  let l:foolen = strlen(l:retval)
  " FIXME: need to find out what usable length of &columns is so user isn't
  " prompted to hit enter on long songs
  let l:nstr = strpart(l:retval, 0, 50)
  if l:foolen >= l:foowinwidth
    echo l:nstr
  else
    echo l:retval
  endif
endfun

fun! s:Xmms(...)
  if a:0
    let l:cmd = a:1
    if l:cmd == "playlist"
      return XMMS_OpenPlaylist(0)
    elseif l:cmd == "filelist"
      return XMMS_OpenPlaylist(1)
    elseif l:cmd == "vol"
      if a:0 == 2
        return s:Cmd_vol(a:2)
      else
        return s:Cmd_vol(input("vol [+|-]percent: "))
      endif
    elseif exists("*s:Cmd_{l:cmd}")
      return s:Cmd_{l:cmd}()
    endif
  endif
  call s:Help()
endfun

fun! s:SongSelector(linenum)
    setlocal ma noswf noro bh=wipe nowrap
    silent %d _
    0insert
# Press <Tab> to enter playlist edit mode
# Press <Enter> to play song at cursor
.
    syn match Comment '^#.*'
    if exists('g:XMMS_TagEncoding')
        let l:tenc = &fileencodings
        exec 'set fileencodings=' . g:XMMS_TagEncoding
    endif
    silent r!xmmsctrl playlist
    if exists('g:XMMS_TagEncoding')
        exec 'set fileencodings=' . l:tenc
    endif
    silent $d _
    setlocal nomodifiable nomodified ro nobuflisted
    let s:in_selector = 1
    mapclear <buffer>
    map <silent> <buffer> <Tab> :call <SID>Playlist(line('.'))<CR>
    map <silent> <buffer> <Return> :call <SID>GotoSong()<CR>
    augroup XMMS
        au!
        au BufEnter \#\#XMMS\#\# call <SID>HiliteCurrent()
        if exists('g:XMMS_AutoSqueeze') && g:XMMS_AutoSqueeze == 1
            au WinLeave \#\#XMMS\#\# call <SID>AutoSqueeze()
        endif
    augroup END
    call s:HiliteCurrent()
    call s:CenterLine(a:linenum)
endfun

fun! s:AutoSqueeze()
    let l:wh = winheight(0)
    augroup XMMS
        exe 'au WinEnter ##XMMS## ' . l:wh . 'wincmd _'
    augroup END
    1wincmd _
    call s:CenterLine(-1)
endfun

fun! s:GotoSong()
    let l:nr = matchstr(getline('.'), '^[0-9]\+')
    if l:nr != ''
        call system('xmmsctrl track ' . l:nr)
    endif
endfun

fun! s:Playlist(linenum)
    setlocal modifiable noro bufhidden=hide nobuflisted
    silent %d _
    let s:in_selector = 0
    0insert
# Press <Tab> to leave editor
# :w loads playlist into XMMS
.
    syn match Comment '^#.*'
    silent r!xmmsctrl playfiles
    silent! %s/^[0-9]\+\s*//g
    silent $d _
    setlocal nomodified
    mapclear <buffer>
    map <silent> <buffer> <Tab> :call <SID>SongSelector(line('.'))<CR>
    augroup XMMS
        au!
        au BufWriteCmd \#\#XMMS\#\#  call <SID>SendPlaylist()
    augroup END
    call s:CenterLine(a:linenum)
endfun

fun! s:SendPlaylist()
    call s:UpdatePlayPos()
    if filewritable($HOME . '/.xmms/')
        let l:t = $HOME . '/.xmms/xmms.m3u'
    else
        let l:t = tempname()
    endif
    exe 'w! ' . l:t
    call system('xmmsctrl stop')
    call system('xmms ' . l:t)
    call system('xmmsctrl play track ' . g:XMMS_playlist_pos)
    setlocal nomodified
endfun

fun! s:CenterLine(num)
    if a:num != -1
        exe 'normal ' . a:num . 'zz'
    else
        if !exists('g:XMMS_playlist_pos')
            call s:UpdatePlayPos()
        endif
        exe 'normal ' . (g:XMMS_playlist_pos + 2) . 'zz'
    endif
endfun

fun! s:UpdatePlayPos()
    let g:XMMS_playlist_pos = matchstr(system('xmmsctrl getpos'), '[0-9]\+')
    if g:XMMS_playlist_pos == ''
        let g:XMMS_playlist_pos = 0
        return
    endif
endfun

fun! XMMS_SongChanged()
    let l:xmms_win = bufwinnr("##XMMS##") 
    if l:xmms_win == -1
        silent! unlet g:XMMS_playlist_pos
        return
    endif
    call s:UpdatePlayPos()
    if s:in_selector
        let l:ei = &ei
        set ei=all
        let l:go_back = 0
        if l:xmms_win != winnr()
            let l:go_back = 1
            exec l:xmms_win . 'wincmd w'
            call s:CenterLine(-1)
        endif
        call s:HiliteCurrent()
        if l:go_back
            wincmd p
        endif
        let &ei = l:ei
        redraw
    endif
endfun

fun! XMMS_OpenPlaylist(mode)
    call foreground()
    let l:xmms_win = bufwinnr('##XMMS##')
    if l:xmms_win == -1
        split \#\#XMMS\#\#
    else
        exec l:xmms_win . 'wincmd w'
    endif
    if a:mode == 0
        call s:SongSelector(-1)
    else
        call s:Playlist(-1)
    endif
    redraw
endfun

fun! s:HiliteCurrent()
    if !exists('g:XMMS_playlist_pos')
        call s:UpdatePlayPos()
    endif
    silent! syn clear XMMSCurrent
    exe 'syn match XMMSCurrent keepend "^' . g:XMMS_playlist_pos . '\>.*$"'
    hi link XMMSCurrent Search
endfun

fun! s:Help()
  echo 'XMMS keys'
  echo '---------'
  echo ':Xmms filelist                    Display filelist'
  echo ':Xmms next, \xn                   Next Song'
  echo ':Xmms pause                       Pause'
  echo ':Xmms play                        Play XMMS'
  echo ':Xmms playlist, \xl               Display playlist'
  echo ':Xmms prev, \xp                   Previous Song'
  echo ':Xmms quit                        Quit XMMS'
  echo ':Xmms remove, \xr                 Remove song currently playing'
  echo ':Xmms shuffle                     Set shuffle to true'
  echo ':Xmms song, \xs                   Song Number and Title'
  echo ':Xmms stop                        Stop'
  echo ':Xmms vol[ [+|-]percent], \xv     Change volume by [+|-] percent'
  return
endfun

fun! XMMS_Complete_Cmd(A,L,P)
  return "filelist\nnext\npause\nplay\nplaylist\nprev\nquit\nremove\nshuffle\nsong\nstop\nvol"
endfun

command! -nargs=* -complete=custom,XMMS_Complete_Cmd Xmms :call s:Xmms(<f-args>)
map <silent> <unique> <Leader>xl :Xmms playlist<CR>
map <silent> <unique> <Leader>xp :Xmms prev<CR>
map <silent> <unique> <Leader>xn :Xmms next<CR>
map <silent> <unique> <Leader>xr :Xmms remove<CR>
map <silent> <unique> <Leader>xs :Xmms song<CR>
map <silent> <unique> <Leader>xv :Xmms vol<CR>

amenu <silent> &XMMS.&Song\ list<TAB>:Xmms\ playlist    :Xmms playlist<CR>
amenu <silent> &XMMS.&File\ list<TAB>:Xmms\ filelist    :Xmms filelist<CR>
amenu <silent> &XMMS.&Next<TAB>:Xmms\ next              :Xmms next<CR>
amenu <silent> &XMMS.Pause<TAB>:Xmms\ pause         :Xmms pause<CR>
amenu <silent> &XMMS.Play<TAB>:Xmms\ play           :Xmms play<CR>
amenu <silent> &XMMS.&Previous<TAB>:Xmms\ prev      :Xmms prev<CR>
amenu <silent> &XMMS.Quit<TAB>:Xmms\ quit           :Xmms quit<CR>
amenu <silent> &XMMS.&Remove<TAB>:Xmms\ remove      :Xmms remove<CR>
amenu <silent> &XMMS.Shuffle<TAB>:Xmms\ shuffle       :Xmms shuffle<CR>
amenu <silent> &XMMS.&Current\ Song<TAB>:Xmms\ song :Xmms song<CR>
amenu <silent> &XMMS.Stop<TAB>:Xmms\ stop          :Xmms stop<CR>
amenu <silent> &XMMS.&Volume.-50   :Xmms vol -50<CR>
amenu <silent> &XMMS.&Volume.-40   :Xmms vol -40<CR>
amenu <silent> &XMMS.&Volume.-30   :Xmms vol -30<CR>
amenu <silent> &XMMS.&Volume.-20   :Xmms vol -20<CR>
amenu <silent> &XMMS.&Volume.-10   :Xmms vol -10<CR>
amenu <silent> &XMMS.&Volume.+10   :Xmms vol +10<CR>
amenu <silent> &XMMS.&Volume.+20   :Xmms vol +20<CR>
amenu <silent> &XMMS.&Volume.+30   :Xmms vol +30<CR>
amenu <silent> &XMMS.&Volume.+40   :Xmms vol +40<CR>
amenu <silent> &XMMS.&Volume.+50   :Xmms vol +50<CR>
" vim: ts=4: sw=4: et
