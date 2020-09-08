call plug#begin()
Plug 'nanotech/jellybeans.vim'
Plug 'zxqfl/tabnine-vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

syntax on
colorscheme jellybeans

set hlsearch
set incsearch
set noerrorbells
set nobackup
set nowritebackup
set noswapfile
set ruler
set showcmd
set autowrite
set autoread
set number
set encoding=utf8
set smartcase

set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set listchars=tab:>-,trail:-
set list

hi Search ctermbg=red
hi Search ctermfg=white

if &term =~ '256color'
    set t_ut=
endif

nmap ,ev :e $MYVIMRC<cr>

autocmd BufNewFile,BufRead *.r nnoremap <F5> :!clear && Rscript %<RETURN>
autocmd BufNewFile,BufRead *.py nnoremap <F5> :!clear && python3 %<RETURN>
autocmd BufNewFile,BufRead *.php nnoremap <F5> :!clear && php %<RETURN>

let s:comment_map = {
            \   "c": '\/\/',
            \   "cpp": '\/\/',
            \   "go": '\/\/',
            \   "java": '\/\/',
            \   "javascript": '\/\/',
            \   "lua": '--',
            \   "scala": '\/\/',
            \   "php": '\/\/',
            \   "python": '#',
            \   "ruby": '#',
            \   "rust": '\/\/',
            \   "sh": '#',
            \   "desktop": '#',
            \   "fstab": '#',
            \   "conf": '#',
            \   "profile": '#',
            \   "bashrc": '#',
            \   "bash_profile": '#',
            \   "mail": '>',
            \   "eml": '>',
            \   "bat": 'REM',
            \   "ahk": ';',
            \   "vim": '"',
            \   "tex": '%',
            \}

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " "
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

nnoremap <C-C> :call ToggleComment()<cr>
vnoremap <C-C> :call ToggleComment()<cr>

map <F7> gg=G<C-o><C-o>
