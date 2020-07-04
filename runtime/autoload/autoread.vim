if exists('g:loaded_watcher_provider')
  finish
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to vim defaults

command! -nargs=1 Watch call autoread#watch_file(expand('<args>'))
command! -nargs=1 Stop call autoread#stop_watch(expand('<args>'))

" function to prompt the user for a reload
function! autoread#PromptReload()
  let choice = confirm("File changed. Would you like to reload?", "&Yes\n&No", 1)
  if choice == 1
    edit!
  endif
endfunction

function! autoread#PrintWatchers()
  call luaeval("vim.autoread.print_all()")
endfunction

function! autoread#watch_file(fname)
  call luaeval("vim.autoread.watch(_A)", a:fname)
endfunction

function! autoread#stop_watch(fname)
  call luaeval("vim.autoread.stop_watch(_A)", a:fname)
endfunction

function! autoread#pause_notif()
  call luaeval("vim.autoread.pause_notif_all()")
endfunction

function! autoread#resume_notif()
  call luaeval("vim.autoread.resume_notif_all()")
endfunction

let &cpo = s:save_cpo " restore user coptions
unlet s:save_cpo

let g:loaded_watcher_provider = 1
