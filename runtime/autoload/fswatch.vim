if exists('g:loaded_watcher_provider')
  finish
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to vim defaults

command! -nargs=1 Watch call v:lua.vim.fswatch.start_watch(expand('<args>'))
command! -nargs=1 Stop call v:lua.vim.fswatch.start_watch(expand('<args>'))

" function to prompt the user for a reload
function! fswatch#PromptReload(buf)
  let choice = confirm("File ".bufname(a:buf)." changed. Would you like to reload?","&Yes\n&Show diff\n&No", 1)
  if choice == 1
    call fswatch#Reload(a:buf)
  elseif choice == 2
    call fswatch#DiffOrig()
  endif
endfunction

" function to reload the buffer
function! fswatch#Reload(buf)
  let s:save_swb = &switchbuf
  execute 'set switchbuf=usetab'
  execute 'sb '.a:buf
  execute 'set switchbuf='.s:save_swb
  edit!
  unlet s:save_swb
endfunction

" function display the diff between the current buffer and original file
function! fswatch#DiffOrig()
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
