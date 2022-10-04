vim.cmd [[
  let g:LargeFile = 1024 * 1024 * 20
  let g:MediumFile = 1024 * 1024 * 2

  augroup LargeFile
    au!
    autocmd BufReadPre * 
      \ let f=getfsize(expand("<afile>")) |
      \ if f > g:LargeFile || f == -2 | 
        \ call LargeFile() |
      \ endif |
      \ if f < g:MediumFile |
        \ call SmallFile() |
      \ else |
        \ call MediumFile() |
      \ endif
  augroup END

  function! SmallFile()
    echo "Small file"
  endfunction

  function! MediumFile()
    echo "Medium file"
  endfunction

  function! LargeFile()
    " no syntax highlighting etc
    set eventignore+=FileType
    " no automatic folds
    set foldmethod=manual
    " save memory when other file is viewed
    setlocal bufhidden=unload
    " is read-only (write with :w new_filename)
    setlocal buftype=nowrite
    " no undo possible
    setlocal undolevels=-1
    " display message
    autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see lua/large-files.lua for details)."
  endfunction
]]
