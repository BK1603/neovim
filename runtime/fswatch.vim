" autocommands for starting filesystem based file watcher

if exists("did_fswatch_on")
  finish
endif
let did_fswatch_on = 1

echo 'loaded fswatch'
augroup fswatch
  autocmd!
  au BufRead,BufWritePost * call luaeval('vim.autoread.watch(_A)', expand('<afile>'))
  au BufDelete,BufUnload,BufWritePre * call luaeval('vim.fswatch.stop_watch(_A)', expand('<file>'))
  au FocusLost * call luaeval('vim.fswatch.pause_watch_all()')
  au FocusGained * call luaeval(('vim.fswatch.resume_notif()')
augroup END
