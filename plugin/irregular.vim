" <C-c> must be used to exit command line mode, rather than <Esc>,
" because Vim treats <Esc> like <CR> in command line mode mappings.
cnoremap <C-CR> <C-c>q/k0y$<C-c><C-c>:call irregular#VimIrregular()<CR><C-w>l/<C-r>"
