
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
	Plug('sheerun/vim-polyglot')
	Plug('itchyny/lightline.vim')
	Plug('kyazdani42/nvim-tree.lua')
	Plug('othree/html5.vim')
	Plug('pangloss/vim-javascript')
	Plug('evanleck/vim-svelte', {branch = 'main'})
	Plug('junegunn/fzf.vim')
	Plug('airblade/vim-gitgutter')
	Plug('neoclide/coc.nvim', {branch = 'release'})
	Plug('akinsho/bufferline.nvim', {tag = 'v2.*'})
vim.call('plug#end')

-- functionality
vim.g.mapleader       = ","
vim.opt.number        = true
vim.opt.scrolloff     = 6
vim.opt.sidescrolloff = 5
vim.opt.wrap          = false
vim.opt.mouse         = 'a'
vim.opt.cmdheight     = 1

-- searching
vim.opt.hlsearch   = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.incsearch  = true

-- sane & efficient
vim.opt.ts = 4
vim.opt.sw = 4
vim.opt.signcolumn = 'number'
vim.opt.lazyredraw = true

-- theme
vim.opt.termguicolors  = true
vim.opt.cursorline     = false
vim.opt.signcolumn     = 'number'
vim.g.colors_name      = 'everforest'
vim.cmd('colorscheme everforest')

-- convenience
vim.cmd('filetype plugin on')
vim.opt.shell = '/bin/bash'
vim.opt.dir = '/tmp/'

-- keybinds
-- general improvements: hide search highlights / move up,down a bit
vim.api.nvim_set_keymap('n', '<Esc>',       ':noh<CR>',            { silent = true, noremap = true })
vim.api.nvim_set_keymap('',  '<PageUp>',    '4k',                  { silent = true })
vim.api.nvim_set_keymap('',  '<PageDown>',  '4j',                  { silent = true })
-- : fzf files / open & focus file tree / reopen previous file / switch between .h(pp) and .c(pp)
vim.api.nvim_set_keymap('n', '<leader>f',   ':GFiles<CR>',         { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>o',   ':NvimTreeFocus<CR>',  { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r',   ':e#<CR>',             { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p',   ':CocCommand clangd.switchSourceHeader<CR>', { silent = true, noremap = true })

-- bufferline
if (false) then
	require('bufferline').setup({
		options = {
			indicator_icon = '▎',
			buffer_close_icon = '',
			modified_icon = '●',
			close_icon = '',
			left_trunc_marker = '',
			right_trunc_marker = '',

			tab_size = 18,
			offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left" }},
			
			show_buffer_icons = false,
			show_buffer_close_icons = false,

			always_show_bufferline = true,
		},
	})
end

-- file tree
require("nvim-tree").setup({
	sort_by = 'case_insensitive',
	hijack_cursor = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	view = {
		adaptive_size = false,
		signcolumn = "no",
		side = "left",
	},
	renderer = {
		group_empty = true,
		highlight_opened_files = 'all', -- or all, name, icon
		icons = {
			webdev_colors = false,
			padding = '',
			show = {
				folder_arrow = true,
				git = false,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
		},
	},
	filters = {
		dotfiles = true,
	},
	filesystem_watchers = {
		enable = true,
		interval = 200,
	},
	git = {
		enable = false,
	},
	actions = {
		change_dir = {
			restrict_above_cwd = true,
		},
	},
})

vim.g.lightline = {
	colorscheme = 'everforest',
	separator = {left = "", right = ""},
	subseparator = {left = "", right = ""},
	active = {
		left  = {{'mode'}, {'readonly', 'filename'}},
		right = {{'gitstatus'}, {'filetype'}},
	},
	inactive = {
		left = {{'filename'}},
		right = {},
	},
	component_function = {
		filename = 'LightlineFilename',
		gitstatus = 'LightlineGitStatus',
	},
	tab = {
		active = {'filename', 'modified'},
		inactive = {'filename', 'modified'},
	},
}

vim.cmd[[
" show filename with modified sign
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineGitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
]]

