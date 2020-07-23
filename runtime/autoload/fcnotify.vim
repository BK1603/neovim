if exists('g:loaded_watcher_provider')
  finish
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to vim defaults

command! -nargs=1 Watch call v:lua.vim.fcnotify.start_watch(expand('<args>'))
command! -nargs=1 Stop call v:lua.vim.fcnotify.start_watch(expand('<args>'))

" function display the diff between the current buffer and original file
function! fcnotify#DiffOrig(buf)
  tab new
  execute 'b '.a:buf
  vert new
  set buftype=nofile
  read ++edit #
  0d_
  diffthis
  wincmd p
  diffthis
  wincmd r
endfunction

let &cpo = s:save_cpo " restore user coptions
unlet s:save_cpo

let g:loaded_watcher_provider = 1
