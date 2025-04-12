lua require("core")
" 光标记忆
augroup JumpCursorOnEdit
	au!
	autocmd BufReadPost *
				\ if expand("<afile>:p:h") !=? $TEMP |
				\   if line("'\"") > 1 && line("'\"") <= line("$") |
				\     let JumpCursorOnEdit_foo = line("'\"") |
				\     let b:doopenfold = 1 |
				\     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
				\        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
				\        let b:doopenfold = 2 |
				\     endif |
				\     exe JumpCursorOnEdit_foo |
				\   endif |
				\ endif
	" Need to postpone using "zv" until after reading the modelines.
	autocmd BufWinEnter *
				\ if exists("b:doopenfold") |
				\   exe "normal zv" |
				\   if(b:doopenfold > 1) |
				\       exe  "+".1 |
				\   endif |
				\   unlet b:doopenfold |
				\ endif
augroup END

augroup dirvish_config
  autocmd!

  " Map `t` to open in new tab.
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> 7 :call dirvish#open('tabedit', 0)<CR>
    \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> 8 :call dirvish#open('split', 0)<CR>
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> 9 :call dirvish#open('vsplit', 0)<CR>

  " Map `gr` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gr :<C-U>Dirvish %<CR>

  " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END
