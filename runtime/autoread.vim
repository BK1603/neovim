" autocommands for starting filesystem based file watcher

if exists("did_autoread_on")
  finish
endif
let did_autoread_on = 1

augroup autoread
  autocmd!
  au BufRead,BufWritePost * call autoread#watch_file(<afile>)
  au BufDelete,BufUnload,BufWritePre * call autoread#stop_watch(<afile>)
  au FocusLost * call autoread#pause_notif()
  au FocusGained * call autoread#resume_notif()
augroup END
