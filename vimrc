" vim:fdm=marker
" vimrc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" License {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copyright 2016 Nebulab

" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at

"     http://www.apache.org/licenses/LICENSE-2.0

" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Setup {{{2
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  " Use Vim settings, rather then Vi settings. This setting must be as early as
  " possible, as it has side effects.
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Common Plugins {{{2
NeoBundle 'tpope/vim-sensible' " Defaults everyone can agree on
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }

" File managers/explorers {{{2
NeoBundle 'Shougo/unite.vim'   " Unite and create user interfaces

" UI {{{2
NeoBundle 'bling/vim-airline'                     " Lean & mean status/tabline for vim that's light as air
NeoBundle 'jszakmeister/vim-togglecursor'         " Toggle the cursor shape in the terminal for Vim

" Editing {{{2
NeoBundle 'tpope/vim-commentary'                  " commentary.vim: comment stuff out

" Git {{{2
NeoBundle 'airblade/vim-gitgutter'                " A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks.
NeoBundle 'tpope/vim-fugitive'                    " fugitive.vim: a Git wrapper so awesome, it should be illegal

" Tmux {{{2
NeoBundle 'benmills/vimux'                        " vim plugin to interact with tmux
NeoBundle 'christoomey/vim-tmux-navigator'        " Seamless navigation between tmux panes and vim splits
NeoBundle 'tmux-plugins/vim-tmux-focus-events'    " Make terminal vim and tmux work better together.
NeoBundle 'edkolev/tmuxline.vim'                  " Simple tmux statusline generator with support for powerline symbols and statusline / airline / lightline integration
NeoBundle 'tmux-plugins/vim-tmux'                 " Vim plugin for tmux.conf

" Ruby/Rails {{{2
NeoBundle 'tpope/vim-rails'                       " rails.vim: Ruby on Rails power tools
NeoBundle 'tpope/vim-bundler'                     " bundler.vim: Lightweight support for Ruby's Bundler
NeoBundle 'tpope/vim-rake'                        " rake.vim: it's like rails.vim without the rails
NeoBundle 'tpope/vim-endwise'                     " endwise.vim: wisely add 'end' in ruby, endfunction/endif/more in vim script, etc

" Syntax {{{2
NeoBundle 'sheerun/vim-polyglot'                  " A solid language pack for Vim.

" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","			  " Leader
set nobackup				  " - Don't let Vim to ever write a backup files
set nowritebackup			  " -
set noswapfile				  " -
set hlsearch				  " Highlight all search pattern matches
set autowrite				  " Automatically :write before running commands
set colorcolumn=80			  " Highlight 80 column
set clipboard=unnamed			  " Copy and Paste from the system clipboard 
set mouse=a				  " Enable mouse use in all modes
set ttyfast				  " Send more characters for redraws
set ttymouse=xterm2			  " Changes what 'mouse codes' will recognise, xterm2 work well with iTerm2 in Mac OS
set hidden				  " Opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed
set number				  " Display line numbers
set numberwidth=5			  " Change line numbers column width
set relativenumber			  " Display line numbers relative to the line with the cursor
set wildmode=list:longest,full            " Command Line configurations 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Options {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline {{{2
let g:airline_powerline_fonts = 1

" Unite {{{2
let g:unite_source_history_yank_enable=1

" let g:unite_source_grep_command='ag'
" let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S'
" let g:unite_source_grep_recursive_opt=''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', { 'start_insert': 1  })

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom {{{2
nnoremap <leader><leader> <c-^>           " Switch between the last two files
nmap <leader>vr :source $MYVIMRC<CR>      " Reload vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>      " Edit vimrc
map <leader>w :write<CR>                  " Save file
map <leader>q :quit<CR>                   " Quit
map <leader>d :bd<CR>                     " Close current buffer
map <leader>Q :quitall<CR>                " Quit All

" Unite {{{2
nnoremap <c-p> :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <c-t> :<C-u>Unite -no-split -buffer-name=buffer -quick-match buffer<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files -start-insert file<cr>
nnoremap <leader>/ :<C-u>Unite -no-split -buffer-name=search -auto-preview -start-insert grep:.<cr>
