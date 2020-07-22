set number
set showmatch
set incsearch
set mouse=a

noremap :wQ :wq
noremap :WQ :wq
noremap :W  :w
noremap :Q  :q

imap jk <Esc>

set nobackup
set nowritebackup
set noswapfile

call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'junegunn/goyo.vim'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf'
Plug 'vimwiki/vimwiki' 
Plug 'junegunn/limelight.vim'
Plug 'qnighy/lalrpop.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/context.vim'
call plug#end()

set undodir=~/.vimdid
set undofile

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set hidden

" Buffers and Ctrl P
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|target',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nnoremap <Space> :CtrlPBuffer<CR>
nnoremap <C-e> :CtrlP<CR>

inoremap jk <Esc>

colo gruvbox
"colorscheme shine

" LINE NUMBER
highlight LineNr ctermfg=grey
highlight Comment ctermfg=grey

" Autocomplete
"enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect

inoremap <c-c> <ESC>

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set shortmess+=c

" ctags

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

" nvim wiki
let mapleader = "-"
let g:vimwiki_list = [{'path': '/home/kper/Dropbox/Zettelkasten',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" disable autocpl in goyo
au BufReadPost,BufNewFile *.md CocDisable
au BufReadPost,BufNewFile *.md CocDisable

"autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

function! s:goyo_enter()
  "set noshowmode
  "set noshowcmd
  "set ruler
  "set scrolloff=999
  Limelight
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()

let g:goyo_width = 70

function SplitInGoyo()
	:Goyo 100
	:VimwikiVSplitLink
endfunction

function ResetGoyo() 
	:q
	:Goyo 70
endfunction

autocmd FileType markdown nnoremap <F1> :VimwikiBacklinks<CR>
"nnoremap <F2> :VimwikiSplitLink<CR>
autocmd FileType markdown nnoremap <F2> :exec SplitInGoyo()<CR>
autocmd FileType markdown nnoremap <F3> :execute ResetGoyo()<CR>


" C Setup

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END


" autocomplete Rust

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%F

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" Explorer

:nmap <space>e :CocCommand explorer<CR>

" Context plugin disable on startup

let g:context_enabled = 0
nnoremap <F1> :ContextToggle<CR>
