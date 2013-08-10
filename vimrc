set nocompatible               " Be iMproved
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" Bundles here:
" Productivity:
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'unite.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'ervandew/supertab'

" Languages:
NeoBundle 'rails.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'jcf/vim-latex'
NeoBundle 'ivalkeen/vim-simpledb'

" gist support
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'

" eyecandy
NeoBundle 'bling/vim-airline'
NeoBundle 'altercation/vim-colors-solarized'

" Installation check.
NeoBundleCheck

let mapleader = ","
colorscheme solarized
set background=light
let g:solarized_termcolors=16

" settings
filetype plugin indent on     " Required!
syntax on
set hidden
autocmd BufWritePre * :%s/\s\+$//e
set encoding=utf-8

set complete=.,w,b,u,t
set completeopt=menuone

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ttyfast
set showcmd

" mapping

nmap <F1> <Esc>
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
map <C-Right> gt
map <A-Right> gt
map <C-Left> gT
map <A-Left> gT
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nnoremap <F3> :nohls<CR>
"fixing the tmux problems
nnoremap [1;5C gt
nnoremap [1;5D gT
nnoremap [H gt

" Fixing screen Problems
map OH <Home>
map OF <End>

inoremap OH <Home>
inoremap OF <End>

" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" Filetypes

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile set filetype=ruby
  autocmd BufRead,BufNewFile vhost.conf set filetype=apache
  autocmd BufRead,BufNewFile .bash_aliases set filetype=sh
  autocmd BufRead,BufNewFile bash_aliases set filetype=sh
  autocmd BufRead,BufNewFile .tmux.conf set filetype=sh
  autocmd BufRead,BufNewFile vhost_ssl.conf set filetype=apache
  autocmd BufRead,BufNewFile *.arb set filetype=ruby
  autocmd BufRead,BufNewFile *.rabl set filetype=ruby
  autocmd BufRead,BufNewFile *.prawn set filetype=ruby
  autocmd BufRead,BufNewFile *.scss set fdm=indent
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent shiftwidth=2 expandtab
  au BufNewFile,BufRead /etc/init/*.conf set ft=upstart
  au BufNewFile,BufRead /etc/init/*.conf set ft=upstart
endif

let g:airline_powerline_fonts = 1
set laststatus=2

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
" ----------------------------------------------------------------------------
"  command line editing
" ----------------------------------------------------------------------------
set history=500     " Save more commands in history
                    " See Practical Vim, by Drew Neil, pg 68

set wildmode=list:longest,full

" File tab completion ignores these file patterns
set wildignore+=*.exe,*.swp,.DS_Store,*~,*.o
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/log/*
set wildignore+=*/coverage/*
set wildignore+=*/public/system/*  " Rails images
set wildmenu

" Add guard around 'wildignorecase' to prevent terminal vim error
if exists('&wildignorecase')
  set wildignorecase
endif

" Supertab Setup

let g:SuperTabDefaultCompletionType = "<c-n>"
