""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Loads plugins
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Leader
let mapleader = ","

" Common
set nobackup
set nowritebackup
set noswapfile                    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set hlsearch                      " highlight all search pattern matches
set autowrite                     " Automatically :write before running commands
set colorcolumn=80
set clipboard=unnamed

" Editing
set fenc=utf-8                    " sets the character encoding for the file of this buffer
set mouse=a                       " enable mouse
set ttyfast                       " This helps when using copy/paste with the mouse in an xterm and other terminals
set hidden                        " Handle multiple buffers better.
set list listchars=tab:»·,trail:· " Display extra whitespace

" Numbers configurations
set number
set numberwidth=5
set relativenumber

" Show current line in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" Command Line configurations
set wildmode=list:longest,list:full

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme base16-tomorrow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline
let g:airline_powerline_fonts = 1

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" NERDTree
let NERDTreeIgnore=['\.rbc$', '\~$']
let NERDTreeShowLineNumbers=1

" CtrlP
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_use_caching = 0 " ag is fast enough that CtrlP doesn't need to cache
endif

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Run Test (Vroom)
let g:vroom_use_vimux = 1
let g:VimuxOrientation = "h"
let g:VimuxHeight = 40
let g:vroom_map_keys = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NerdTree Toggle
map <F2> :NERDTreeToggle<CR>

" TagBar Toggle
nmap <F3> :TagbarToggle<CR>

" CtrlP Ctags
nnoremap <leader>. :CtrlPTag<cr>

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Edit vimrc
nmap <leader>vr :source $MYVIMRC<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>

" bind K to grep word under cursor
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

" Ag
map <leader>/ :Ag<space>

" Write and quit on the fly
map <leader>w :write<CR>
map <leader>q :quit<CR>
map <leader>d :bd<CR>
map <leader>Q :quitall<CR>

" Vim Fugitive stuff
nmap <leader>gs :Gstatus<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gb :Gbrowse<CR>

" Rails stuff
map ga :A<CR>
map gr :R<CR>

" Split
map <leader>\| :vsplit<CR>
map <leader>- :split<CR>

" Indent file
map <f7> gg=G

" Add pry to debug
map <Leader>bp obinding.pry<esc>:w<cr>
map <Leader>bP Obinding.pry<esc>:w<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specific file types configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  autocmd BufRead,BufNewFile *.md set colorcolumn=80

  autocmd BufRead,BufNewFile *.es6 set filetype=javascript
augroup END

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
