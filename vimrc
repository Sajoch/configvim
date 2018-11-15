" VIM and programming specific
syntax on
set nocompatible
set nowrap
set encoding=utf8
set nobackup
set nowritebackup
set ruler
let mapleader = "\\"

" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

let g:elite_mode=1



highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

call plug#begin('~/.vim/plugged')

" Colors
Plug 'ErichDonGubler/vim-sublime-monokai'

" CTags plugin
Plug 'ludovicchabant/vim-gutentags'

" Essential plugins
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" GIT
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Programming
Plug 'Townk/vim-autoclose'
Plug 'w0rp/ale'

" Syntax PHP
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'

" PHP Completion
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

" PHP Doc
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'

" Tagbar
Plug 'majutsushi/tagbar'

" Devicons (needs nerd font!)
"Plug 'ryanoasis/vim-devicons'

call plug#end()

" Autoload NERDtree on vim start
autocmd vimenter * NERDTree

" Autoload NERDtree on entering vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Autoload NERDtree when opening directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Focus on file instead of NERDtree
autocmd VimEnter * wincmd p

" Autoclose when only NERDTree / quickfix / tagbar / help windows are left
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction

autocmd BufEnter * call CheckLeftBuffers()


" AIRLINE
set noshowmode

" Status line for ALE in airline
let g:airline#extensions#ale#enabled = 1

" ELITE MODE
if get(g:, 'elite_mode')
        nnoremap <Up>    :resize +2<CR>
        nnoremap <Down>  :resize -2<CR>
        nnoremap <Left>  :vertical resize +2<CR>
        nnoremap <Right> :vertical resize -2<CR>
endif

set t_Co=256
set background=dark
colorscheme sublimemonokai
