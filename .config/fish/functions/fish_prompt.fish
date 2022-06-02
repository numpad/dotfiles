
function fish_prompt --description 'Write out the prompt'
	switch $status
		case 0
			set_color green
		case '*'
			set_color red
	end

	echo -n ' > '
	set_color normal
end

function fish_right_prompt
	set_color black
	echo -en "$(prompt_pwd) "
	set_color normal
end

