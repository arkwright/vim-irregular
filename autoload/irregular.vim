function! irregular#VimIrregular()
  let l:bufferName = '[Irregular]'

  " Toggle closed if already open.
  if bufexists(l:bufferName)
    " The slashes are necessary to escape the [ and ]
    " characters in the buffer name.
    execute 'bwipeout! \' . l:bufferName . '\'
  else
    " Open new split.
    execute 'noswapfile leftabove 45vnew ' . l:bufferName

    " Make modifiable if not already.
    setlocal modifiable

    " Empty contents if that buffer was previously open.
    execute '%d'

    " Insert text.
    call append(0, [
\'           REGEX CHEATSHEET          ',
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
\'\a               alphabetic character',
\'\A           non-alphabetic character',
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
\])

    " Make it immutable.
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nomodifiable
  endif
endfunction
