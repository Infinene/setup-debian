syntax on
set background=dark
filetype plugin indent on
set nocompatible	" Use Vim defaults (much better!)
set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
set mouse=a			" Enable mouse usage (all modes)
set bs=2			" Allow backspacing over everything in insert mode
set autowrite 		" Always set auto-indenting on
set history=50		" keep 50 lines of command history
set ruler			" Show the cursor position all the time
set number			" show line nubers
set tabstop=4
set shiftwidth=4
"set softtabstop=0
set nomodeline
filetype plugin indent on

" Don't use Ex mode, use Q for formatting
map Q gq

" When doing tab completion, give the following files lower priority.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo

command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
