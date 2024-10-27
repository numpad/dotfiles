function! AutoBranch()
	" don't do anything when amending
	if getline(1) == ""
		let branch = trim(system('git branch --show-current 2>/dev/null'))
		let ticket_match = matchstr(branch, '\v^(feature|bugfix|hotfix)\/(\u+-?[0-9]+)')
		" only add prefix when branch name matches
		if ticket_match != ""
			let only_ticket = matchstr(ticket_match, '\v\u+-?[0-9]+$')
			call append(0, "[" . only_ticket . "] ")
			execute "norm k"
		endif
		" start in insert mode
		startinsert!
	end
endfunction

:call AutoBranch()

