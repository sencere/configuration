call plug#begin()
Plug  'nanotech/jellybeans.vim' 
Plug 'zxqfl/tabnine-vim'
call plug#end()

syntax on
colorscheme jellybeans

set hlsearch
set incsearch
set backspace=2 
set noerrorbells
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set laststatus=2  
set autowrite
set autoread
set expandtab
set shiftwidth=4
set softtabstop=4
set number
set expandtab
set encoding=utf8
set smartcase

hi Search ctermbg=red
hi Search ctermfg=white

if &term =~ '256color'
    set t_ut=
endif

autocmd BufNewFile,BufRead *.r nnoremap <F5> :!clear && Rscript %<RETURN>
autocmd BufNewFile,BufRead *.py nnoremap <F5> :!clear && python3 %<RETURN>
autocmd BufNewFile,BufRead *.php nnoremap <F5> :!clear && php %<RETURN>

nmap ,ev :e $MYVIMRC<cr> 
