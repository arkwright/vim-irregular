let g:irregular_register = 'z'

function! irregular#Irregular()
  let l:bufferName = '[Irregular]'

  let l:currentBuffer = winbufnr(0)

  " Toggle closed if already open.
  if bufexists(l:bufferName)
    " The slashes are necessary to escape the [ and ]
    " characters in the buffer name.
    execute 'bwipeout! \' . l:bufferName . '\'
  else
    let l:mode = strpart(getreg(g:irregular_register), 0, 1)
    let l:command = strpart(getreg(g:irregular_register), 1)

    " Open new split.
    execute 'noswapfile leftabove 38vnew ' . l:bufferName

    " Make modifiable if not already.
    setlocal modifiable

    " Empty contents if that buffer was previously open.
    execute '%d'

    " Insert text.
    call append(0, [
\'=====================================',
\'         REGEX CHEATSHEET (\v)       ',
\'=====================================',
\'^                       start-of-line',
\'$                         end-of-line',
\'.                       any character',
\'=====================================',
\'\s               whitespace character',
\'\S           non-whitespace character',
\'\d                              digit',
\'\D                          non-digit',
\'\a               alphabetic character',
\'\A           non-alphabetic character',
\'\t                              <Tab>',
\'\r                               <CR>',
\'\b                               <BS>',
\'\e                              <Esc>',
\'=====================================',
\'[]        any character inside the []',
\'[^]   any character NOT inside the []',
\'()            group pattern inside ()',
\'\1            refer to first () group',
\'=====================================',
\'*                           0 or more',
\'+                           1 or more',
\'=                              0 or 1',
\'?                              0 or 1',
\'{n,m}                          n to m',
\'{n}                         exactly n',
\'{n,}                       at least n',
\'{,m}                           0 to m',
\'{}                          0 or more',
\'{-n,m}                n to m (fewest)',
\'{-n,}             at least n (fewest)',
\'{-,m}                 0 to m (fewest)',
\'{-}                0 or more (fewest)',

\{-n,m}	matches n to m of the preceding atom, as few as possible
\{-n}	matches n of the preceding atom
\{-n,}	matches at least n of the preceding atom, as few as possible
\{-,m}	matches 0 to m of the preceding atom, as few as possible
\{-}	matches 0 or more of the preceding atom, as few as possible
\])

    " Make it immutable.
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nomodifiable

    " Maximize available space
    setlocal nonumber
    setlocal norelativenumber
    setlocal foldcolumn=0

    " Return to the starting window.
    execute 'normal! ' . bufwinnr(l:currentBuffer) . "\<C-w>w"
    ". "\<C-r>" . g:irregular_register
  endif
endfunction

" <C-\>e is used to replace the command line with the result of an expression.
" This is the only way I have found of detecting and saving the current
" command line mode (e.g. /, ?, or :). The mode is encoded along with the
" command line contents and stored in a register, because <C-\>e is executed
" in Vim's 'sandbox' which does not allow setting buffer local variables.
" Since <C-\>e replaces the current command line contents with the result of
" the expression, and since setreg() always returns 0, a conditional operator
" (?:) is used to ensure that the return value of getcmdline() ends up filling
" the current command line. The effect is that the user's search history
" (accessible via q/) contains the current command line contents, rather than
" just the number 0.
"
" <C-c> must be used to exit command line mode, rather than <Esc>, because Vim
" treats <Esc> like <CR> in command line mode mappings.
"
" When exiting command line mode using <C-c>, Vim stores the partially-entered
" commmand in the command history, which is accessible by pressing q/ or q:.
execute 'cnoremap <C-CR> <C-\>esetreg(''' . g:irregular_register . ''', getcmdtype().getcmdline())?0:getcmdline()<CR><C-c>:call irregular#Irregular()<CR>/'
