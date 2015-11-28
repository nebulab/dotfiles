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
set ttymouse=xterm2
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

if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif
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

" TagBar configuration for rspec
let g:tagbar_type_ruby = {
  \ 'kinds' : [
      \ 'm:modules',
      \ 'c:classes',
      \ 'd:describes',
      \ 'C:contexts',
      \ 'f:methods',
      \ 'F:singleton methods'
  \ ]
\ }

" Unite
let g:unite_source_history_yank_enable=1

let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S'
let g:unite_source_grep_recursive_opt=''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', { 'start_insert': 1  })

" VimFiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_quick_look_command = 'qlmanage -p'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" VimFilerToggle
nmap <F2> :VimFilerExplorer<CR>

" TagBar Toggle
nmap <F3> :TagbarToggle<CR>

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Edit vimrc
nmap <leader>vr :source $MYVIMRC<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>

" bind K to grep word under cursor
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

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

" Unite
nnoremap <c-p> :<C-u>Unite -no-split -buffer-name=files  -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <c-space> :<C-u>Unite -no-split -buffer-name=buffer -quick-match buffer<cr>
nnoremap <leader>/ :<C-u>Unite -no-split -buffer-name=search -auto-preview -start-insert grep:.<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <esc> <plug>(unite_exit)
endfunction

" Vimfiler
autocmd FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings()
  nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
  nmap <buffer> c <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)
  nmap <buffer> m <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_move_file)
  nmap <buffer> d <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_delete_file)
  nmap <buffer> <c-l> <c-w>l
endfunction

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
