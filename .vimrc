filetype indent plugin on
syntax on
colorscheme desert

set showcmd                     " (sc) display an incomplete command in the lower right
set ruler                       " (ru) show the cursor position at all times
set visualbell             	" (vb) set visual bell

" Search
" case-insensitive search
set incsearch                   " (is) highlights what you are searching for as you type
set ignorecase                  " (ic) ignores case in search patterns
set smartcase                   " (scs) don't ignore case when the search pattern has uppercase
set infercase                   " (inf) during keyword completion, fix case of new word (when ignore case is on)

" Indenting
" ------------
" smartindent = tries to understand C
" cindent = smarter
set autoindent                  " (ai) copy indent from current line when starting a new line
set copyindent                  " (ci) when auto-indenting, use the indenting format of the previous line
set smartindent                 " (si) enable the smartindenting feature for the following files
set cindent
set tabstop=2                   " (ts) width (in spaces) that a <tab> is displayed as
set expandtab                   " (et) expand tabs to spaces (use :retab to redo entire file)
set shiftwidth=2                " (sw) width (in spaces) used in each step of autoindent (aswell as << and >>)
set shiftround                  " (sr) indent/outdent to nearest tabstop

set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:␣

set nu
set mouse=a
