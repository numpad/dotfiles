-- Todos & Ideas
--
-- [ ] Fix PgUp/Down for insert mode
-- [ ] Auto-Select text after pasting?
-- [ ] Window Switching in insert (clashes with word jumping)
--

-- disable netrw (why?)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvimgdb_disable_start_keymaps = 1

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
	Plug('itchyny/lightline.vim')
	Plug('nvim-tree/nvim-tree.lua')
	Plug('airblade/vim-gitgutter')
	-- DISABLE_COC: Plug('neoclide/coc.nvim', {branch = 'release'})
	Plug('luochen1990/rainbow')
	Plug('ellisonleao/gruvbox.nvim')
	Plug('nvim-lua/plenary.nvim')
	Plug('nvim-telescope/telescope.nvim') --, {tag = '0.1.1'})
	Plug('axkirillov/easypick.nvim', { requires = 'nvim-telescope/telescope.nvim' })
	Plug('sakhnik/nvim-gdb')
	Plug('tpope/vim-surround')
	Plug('lambdalisue/vim-manpager')
	Plug('echasnovski/mini.nvim')
	Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
	Plug('wfxr/minimap.vim') -- requires "yay -S code-minimap"
	Plug('lfv89/vim-interestingwords')
	Plug('FabijanZulj/blame.nvim')
	Plug('romgrk/nvim-treesitter-context')
	Plug('andymass/vim-matchup')

	-- Complete
		Plug('neovim/nvim-lspconfig')
		Plug('hrsh7th/nvim-cmp')
		Plug('hrsh7th/cmp-nvim-lsp')
		Plug('hrsh7th/cmp-buffer')
		Plug('hrsh7th/cmp-path')
		Plug('hrsh7th/cmp-cmdline')


	-- Languages
		Plug('Tetralux/odin.vim')
		Plug('othree/html5.vim')
		Plug('pangloss/vim-javascript')
		Plug('elixir-tools/elixir-tools.nvim', { tag = 'stable', requires = 'nvim-lua/plenary.nvim' })

	-- Mine
		-- Plug('~/dev/nvim-plugins/inline-chatgpt', { requires = 'nvim-telescope/telescope.nvim' })

	-- Fun, Remove maybe
		Plug('eandrju/cellular-automaton.nvim')

	-- Folding: https://github.com/kevinhwang91/nvim-ufo
		-- Plug('kevinhwang91/promise-async')
		-- Plug('kevinhwang91/nvim-ufo')

	-- Check out at some point:
		--Plug('L3MON4D3/LuaSnip', { tag = 'v2.3.0', ['do'] = 'make install_jsregexp' })
		-- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316

	-- No Longer Used:
		-- Plug('junegunn/fzf.vim') -- Replaced by telescope
vim.call('plug#end')

-- functionality
vim.g.mapleader       = ","
vim.opt.number        = true
vim.opt.scrolloff     = 3
vim.opt.sidescrolloff = 20
vim.opt.wrap          = false
vim.opt.mouse         = 'a'
vim.opt.cmdheight     = 1
vim.opt.splitkeep     = "screen"

-- searching
vim.opt.hlsearch   = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.incsearch  = true

-- sane & efficient
vim.opt.ts = 4
vim.opt.sw = 4
vim.opt.lazyredraw = true
vim.opt.updatetime = 750
vim.opt.formatoptions:remove({"r", "o"}) -- CoC or something overwrites this -_-

-- theme
vim.opt.termguicolors  = true
vim.opt.cursorline     = true
vim.opt.colorcolumn    = ''
vim.opt.signcolumn     = 'number'
vim.opt.list           = true
vim.opt.listchars      = { tab='| ', trail='#', nbsp='x', lead='.' }
vim.g.rainbow_active   = 1
vim.o.background       = 'dark'
require("gruvbox").setup({
	undercurl            = true,
	underline            = true,
	bold                 = true,
	italic               = true, -- is this nice?
	strikethrough        = true,
	invert_selection     = false,
	invert_signs         = false,
	invert_tabline       = false,
	invert_intend_guides = false,
	inverse              = false, -- invert background for search, diffs, statuslines and errors
	contrast             = "soft", -- can be "hard", "soft" or empty string
	palette_overrides    = {},
	overrides            = {},
	dim_inactive         = false,
	transparent_mode     = false,
})
vim.cmd('colorscheme gruvbox')

-- convenience
vim.cmd('filetype plugin on')
vim.opt.shell = '/bin/bash'
vim.opt.dir = '/tmp/'
-- vim.cmd("autocmd CursorHold * silent call CocActionAsync('highlight')") -- highlight the symbol and its references when holding the cursor.

---------------------
-- Language Server --
---------------------

local lspconfig = require('lspconfig')
-- Python
-- lspconfig.pyright.setup({})
-- Odin
lspconfig.ols.setup({})
-- C/C++:
lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		-- Show hover docs
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>qs', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>qr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>qd', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>qf', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

		-- Show parameter/signature help
		vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
	end,
})


-------------------
-- Auto Complete --
-------------------

local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources(
		{
			{ name = 'nvim_lsp' },
		},
		{
			{ name = 'buffer' },
			{ name = 'path' },
		}
	),
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, vim_item)

			-- Kind icons
			local kind_icons = {
				Text = 'text',
				Method = 'Meth',
				Function = 'fn',
				Constructor = 'Cons',
				Field = 'memb',
				Variable = 'var',
				Class = 'Cls',
				Interface = 'If',
				Module = 'Mod',
				Property = 'Prop',
				Unit = 'unit',
				Value = 'val',
				Enum = 'enum',
				Keyword = 'Keyw',
				Snippet = 'snip',
				Color = 'col',
				File = 'File',
				Reference = 'Ref',
				Folder = 'Dir',
				EnumMember = 'enum',
				Constant = 'C',
				Struct = 'strc',
				Event = 'Evnt',
				Operator = 'op',
				TypeParameter = 'T',
			}

			vim_item.kind = string.format('%s', kind_icons[vim_item.kind] or '')
			return vim_item
		end,
	},
})

-- Colors
vim.cmd([[
	highlight CmpItemKindVariable guifg=#E06C75
	highlight CmpItemKindFunction guifg=#B7BA26
	highlight CmpItemKindEnum guifg=#D28598
	highlight CmpItemKindStruct guifg=#C678DD
]])


----------------------
-- Telescope Config --
----------------------

local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local telescope_actions = require('telescope.actions')

telescope.setup({
	defaults = {
		mappings = {
			i = {
				['<esc>'] = telescope_actions.close,
				['<c-d>'] = telescope_actions.delete_buffer,
			},
		},
		layout_config = {
			vertical = { width = 0.5 },
		},
	},
	pickers = {
		find_files = {
			--theme = "dropdown",
		},
		buffers = {
			--theme = "dropdown",
			sort_lastused = true,
			ignore_current_buffer = true,
		}
	},
	extensions = {},
})

local telescope_last = nil
function telescope_resume_livegrep()
	if telescope_last ~= 'live_grep' then
		telescope_last = 'live_grep'
		telescope_builtin.live_grep()
	else
		telescope_builtin.resume()
	end
end
function telescope_resume_find_files()
	if telescope_last ~= 'find_files' then
		telescope_last = 'find_files'
		telescope_builtin.find_files()
	else
		-- Resume feels counterproductive with find_files
		-- telescope_builtin.resume()
		telescope_builtin.find_files()
	end
end


-----------------
-- Keybindings --
-----------------

-- general improvements: hide search highlights / move up,down a bit
vim.api.nvim_set_keymap('n', '<Esc>',      ':noh<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('',  '<PageUp>',   '4k',       { silent = true })
vim.api.nvim_set_keymap('',  '<PageDown>', '4j',       { silent = true })
vim.api.nvim_set_keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>z',  ':ZenMode<CR>',                              { noremap = true })
vim.api.nvim_set_keymap('n', '-',          '%', { silent = true, noremap = true })

-- "fzf" files
-- vim.api.nvim_set_keymap('n', '<leader>f',  ':Telescope find_files<CR>',                 { silent = true, noremap = true })
vim.keymap.set         ('n', '<leader>f',  telescope_resume_find_files)
vim.keymap.set         ('n', '<leader>F',  telescope_resume_livegrep)
vim.api.nvim_set_keymap('n', '<leader>d',  ':Telescope buffers<CR>',                    { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>D',  ':Telescope grep_string<CR>',                { silent = true, noremap = true })

-- open & focus file tree / reopen previous file / switch between .h(pp) and .c(pp)
vim.api.nvim_set_keymap('n', '<leader>o',  ':NvimTreeFocus<CR>',                        { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r',  ':b#<CR>',                            { silent = true, noremap = true })
-- DISABLE_COC: vim.api.nvim_set_keymap('n', '<leader>p',  ':CocCommand clangd.switchSourceHeader<CR>', { silent = true, noremap = true })
-- DISABLE_COC: vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()',                              { silent = true, expr = true    })

-- window & tabs
vim.api.nvim_set_keymap('n', '<leader>w',  '<C-w>',                                     { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qq', ':bd<CR>',                                   { silent = true })
vim.api.nvim_set_keymap('t', '<Esc>',      '<C-\\><C-n>',                               { silent = true, noremap = true })
for i = 1, 10 do
	vim.api.nvim_set_keymap('n', string.format('<leader>%d', i % 10),
	                        string.format('%dgt', i), { silent = true, noremap = true })
end
vim.api.nvim_set_keymap('n', '<C-Left>',   '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Right>',  '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Up>',     '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Down>',   '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<CS-Left>',  '<C-w>H', { noremap = true })
vim.api.nvim_set_keymap('n', '<CS-Right>', '<C-w>L', { noremap = true })
vim.api.nvim_set_keymap('n', '<CS-Up>',    '<C-w>K', { noremap = true })
vim.api.nvim_set_keymap('n', '<CS-Down>',  '<C-w>J', { noremap = true })

-- buffer
vim.api.nvim_set_keymap('n', '<S-Up>',       '<C-y>',           { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Down>',     '<C-e>',           { noremap = true })
vim.api.nvim_set_keymap('n', '<S-PageUp>',   '<C-y><C-y><C-y>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-PageDown>', '<C-e><C-e><C-e>', { noremap = true })

-- some coc-specific stuff
vim.api.nvim_set_keymap('n', '<leader>qr', '<Plug>(coc-rename)',                  { silent = true })
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)',             { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ql', ':CocList diagnostics<CR>',            { silent = true })
vim.api.nvim_set_keymap('n', '<leader>qo', ':CocList outline<CR>',                { silent = true })
vim.api.nvim_set_keymap('n', '<leader>qs', ':call CocActionAsync("doHover")<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>qd', ':call CocActionAsync("jumpDefinition")<CR>', { silent = true })

-- visual stuff
vim.api.nvim_set_keymap('n', '<leader>gg', ':GitGutterToggle<CR>',     { silent = true })
vim.api.nvim_set_keymap('n', '<leader>gm', ':MinimapToggle<CR>',       { silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':BlameToggle virtual<CR>', { silent = true })

-- code context
vim.api.nvim_set_keymap('n', '<leader>i', ':call InterestingWords("n")<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>I', ':call UncolorAllWords()<CR>',     { silent = true })

-- fun
vim.api.nvim_set_keymap('n', '<leader>G', ':CellularAutomaton make_it_rain<CR>',     { silent = true })


-----------
-- Align --
-----------

require('mini.align').setup({
	mappings = {
		start = '<leader>a',
		start_with_preview = '<leader>A',
	},
})


--------------
-- Filetree --
--------------

require("nvim-tree").setup({
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
				folder_arrow = false,
				git = false,
			},
			glyphs = {
				default = "",
				symlink = "@",
				folder = {
					arrow_closed = "→",
					arrow_open   = "↓",
					default      = "", -- 
					open         = "", -- 
					empty        = "", -- 
					empty_open   = "", -- 
					symlink      = "", -- 
					symlink_open = "", -- 
				},
			},
		},
	},
	filters = {
		dotfiles = true,
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
	separator = {left = "", right = ""},
	subseparator = {left = "", right = ""},
	active = {
		left  = {{'mode'}, {'readonly', 'filename'}},
		right = {{'gitstatus'}},
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

local easypick = require('easypick')
easypick.setup({
	pickers = {
		{
			name = 'modified',
			command = "git diff --name-only $(git merge-base HEAD develop)",
			previewer = easypick.previewers.branch_diff({ base_branch = 'develop' }),
		}
	},
})


-------------------------
-- My Personal Plugins --
-------------------------

--local inlinegpt = require('/home/chris/dev/nvim-plugins/inline-chatgpt/lua/inline-gpt/init.lua')
--inlinegpt.setup()


-----------------------
-- Configure Minimap --
-----------------------
vim.g.minimap_width = 10
vim.g.minimap_auto_start = 0
vim.g.minimap_auto_start_win_enter = 0
vim.g.minimap_highligt_search = 1
vim.g.minimap_highligt_range = 1


-----------------------
-- Interesting Words --
-----------------------

vim.g.interestingWordsDefaultMappings = 0
vim.g.interestingWordsRandomiseColors = 0
vim.g.interestingWordsGUIColors = {
	'#5f4363', '#634543', '#635c43', '#576343', '#43634e', '#436163', '#435063', '#4c4363',
	'#ff0000', '#00ff00', '#0000ff', '#ffff00', '#00ffff', '#ff00ff'
}


---------------
-- Git Blame --
---------------

local blame = require('blame')
blame.setup()


------------------------
-- Treesitter-Context --
------------------------

local tscontext = require('treesitter-context')
tscontext.setup({
	enable = true,
	max_lines = -1,
	line_numbers = true,
	trim_scope = 'outer',
	mode = 'cursor',
	zindex = 20,
	on_attach = nil,
})


------------
-- Elixir --
------------

if (false) then
	local elixir = require('elixir')
	local elixirls = require("elixir.elixirls")
	elixir.setup({
		nextls   = {enable = false},
		credo    = {enable = false},
		elixirls = {
			enable = true,
			repo = "elixir-lsp/elixir-ls",
			tag = "v0.22.0",
			settings = elixirls.settings({
				dialyzerEnabled = true,
				fetchDeps = false,
				enableTestLenses = true,
				suggestSpecs = false,
			}),
			--on_attach = function(client, bufnr)
			--	vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
			--	vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
			--	vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
			--end
		},
	})
end

