" -----------------------------------------------------------------------------
"     - Main Configuration -
" -----------------------------------------------------------------------------

call plug#begin()
Plug 'nanotech/jellybeans.vim'
" Plug 'zxqfl/tabnine-vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'andys8/vim-elm-syntax'
Plug 'joonty/vdebug'
Plug 'yggdroot/indentline'
Plug 'sbdchd/neoformat'
Plug 'jbmorgado/vim-pine-script'
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
set rtp+=~/tabnine-vim

hi Search ctermbg=red
hi Search ctermfg=white
hi MatchParen cterm=none ctermbg=green ctermfg=blue
hi Normal guisp=NONE guifg=#e8e8cc guibg=#1c1c1c ctermfg=253 gui=NONE cterm=NONE


if &term =~ '256color'
    set t_ut=
endif

nmap ,ev :e $MYVIMRC<cr>
map <F6> gg=G<C-o><C-o>


let g:neoformat_try_node_exe = 1

" -----------------------------------------------------------------------------
"     - Execute Script Files via F5 -
" -----------------------------------------------------------------------------

autocmd BufNewFile,BufRead *.r nnoremap <F5> :!clear && Rscript %<RETURN>
autocmd BufNewFile,BufRead *.py nnoremap <F5> :!clear && python3 %<RETURN>
autocmd BufNewFile,BufRead *.sh nnoremap <F5> :!clear && sh %<RETURN>
autocmd BufNewFile,BufRead *.js nnoremap <F5> :!clear && node %<RETURN>
autocmd BufNewFile,BufRead *.vue nnoremap <F5> :!clear && node %<RETURN>
autocmd BufNewFile,BufRead *.php nnoremap <F5> :!clear && php %<RETURN>
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.vue Neoformat

" -----------------------------------------------------------------------------
"     - Toggle Comments -
" -----------------------------------------------------------------------------

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
    \   "r": '#',
    \}

" -----------------------------------------------------------------------------
"     - VDebug Configuration -
" -----------------------------------------------------------------------------

let g:vdebug_options = {}
let g:vdebug_options['break_on_open'] = 1
let g:vdebug_options['max_children'] = 128
let g:vdebug_options['watch_window_style'] = 'compact'
let g:vdebug_options['ide_key'] = 'VIMDEBUG'

let g:vdebug_options = {
            \    'port' : 9090,
            \    'timeout' : 20,
            \    'server' : '',
            \    'on_close' : 'stop',
            \    'break_on_open' : 1,
            \    'ide_key' : '',
            \    'debug_window_level' : 0,
            \    'debug_file_level' : 0,
            \    'debug_file' : '~/vdebug.log',
            \    'path_maps' : {},
            \    'watch_window_style' : 'expanded',
            \    'marker_default' : '⬦',
            \    'marker_closed_tree' : '▸',
            \    'marker_open_tree' : '▾',
            \    'sign_breakpoint' : '▷',
            \    'sign_current' : '▶',
            \    'continuous_mode'  : 1,
            \    'simplified_status': 1,
            \    'layout': 'vertical',
            \}

let g:vdebug_keymap = {
            \    "run" : "<F2>",
            \    "set_breakpoint" : "<F3>",
            \    "run_to_cursor" : "<F4>",
            \    "step_over" : "<F7>",
            \    "step_into" : "<F8>",
            \    "step_out" : "<F9>",
            \    "close" : "<F12>",
            \    "detach" : "<C-F12>",
            \    "eval_visual" : "<Leader>e",
            \}


function! InsertPythonFirstLine()
    " Save the current position
    let l:pos = getpos(".")
    " Insert "#!/usr/bin/python" at the current line
    call append(l:pos[1] - 1, '#!/usr/bin/python')
    " Restore the cursor position
    call setpos('.', l:pos)
endfunction

command! Flpython call InsertPythonFirstLine()


" Enable true colors
if has('termguicolors')
  set termguicolors
endif

" Load jellybeans theme
colorscheme jellybeans

" Keep the background transparent and make sure it sticks after theme loads
autocmd VimEnter,ColorScheme * call s:MakeTransparent()

function! s:MakeTransparent() abort
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE ctermbg=NONE
  hi LineNr guibg=NONE ctermbg=NONE
  hi NormalFloat guibg=NONE ctermbg=NONE
endfunction


