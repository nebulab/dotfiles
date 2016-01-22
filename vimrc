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
NeoBundle 'tpope/vim-sensible' " Defaults everyone can agree on
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
