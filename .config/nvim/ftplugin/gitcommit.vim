function! AutoBranch()
  " don't do anything when amending
  if getline(1) == ""
    let branch = trim(system('git branch --show-current 2>/dev/null'))
    let ticket_match = matchstr(branch, '\v^\u\u\u-?[0-9]+')
    " only add prefix when branch name matches
    if ticket_match != ""
      call append(0, "[" . ticket_match . "] ")
      execute "norm k"
    endif
    " start in insert mode
    startinsert!
  end
endfunction

:call AutoBranch()

