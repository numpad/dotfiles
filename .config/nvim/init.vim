
" plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
" filebrowser + Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" colors
Plug 'ayu-theme/ayu-vim'
"Plug 'arcticicestudio/nord-vim'
" svelte
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()

" functionality
set number
set scrolloff=6
set nowrap
set mouse=a
set cmdheight=1

" searching
set hlsearch
set ignorecase
set smartcase
set incsearch
nnoremap <Esc> :noh<CR>

" sane
set ts=4
set sw=4

" efficient
set lazyredraw

" theme
set termguicolors
set nocursorline
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_italic=1
colorscheme everforest
syntax enable

" filetype specific stuff
filetype plugin on

" default shell
set shell=/bin/fish

" swap files to /tmp
set dir=/tmp

" lightline setup
let g:lightline = {
	\ 'colorscheme': 'everforest',
	\ 'active': {
	\     'left': [ ['mode'], ['readonly', 'filename'] ],
	\     'right': [ ['filetype'] ]
	\ },
	\ 'inactive': {
	\     'left': [ ['filename'] ],
	\     'right': []
	\ },
	\ 'component_function': {
	\     'filename': 'LightlineFilename',
	\ },
	\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
	\ }
let g:lightline.tab = {
	\ 'active' : [ 'filename', 'modified' ],
	\ 'inactive' : [ 'filename', 'modified' ] }

" show filename with modified sign
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

