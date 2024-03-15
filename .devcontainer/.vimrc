syntax on
filetype plugin indent on

" colo darkblue
" colo monokai
set t_Co=256
set t_ut=
colorscheme codedark

" Configuration vim Airline
set laststatus=2

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

set noshowmode

" Configuration NERDTree
map <F5> :NERDTreeToggle<CR>

" Configuration floaterm
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

" Configuration Vim.FZF
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

set autoindent expandtab tabstop=2 shiftwidth=2
let g:gitgutter_enabled = 0

set hlsearch

" tell vim to keep a backup file
set backup

" tell vim where to put its backup files
set backupdir=/tmp

" tell vim where to put swap files
set dir=/tmp

