"~/.vimrc - sourced when vim starts, vim personalizations

""""""""""""""""""""""""""""""""""""
"Colors, Personalizations, and Such"
""""""""""""""""""""""""""""""""""""
"{{{
    set nowrap
    "set colors
    set t_Co=256
    colorscheme Tomorrow-Night-Eighties
    "Don't keep a history I don't want
    let g:netrw_dirhistmax = 0
    "unnecessary
    set noswapfile
    set noshowmode
    "change tabs to be 4 spaces
    set tabstop=4
    set softtabstop=4
    set expandtab
    "for >>/<< operators
    set shiftwidth=4
    "show line numbers
    set number
    set relativenumber
    "show current line on
    set cursorline
    "highlight CursorLine term=bold cterm=bold
    "redraw less often, faster maybe
    set lazyredraw
    "show matches to parentheses and such
    "set showmatch
    "only show matches for 3 tenths of a sec
    "set matchtime=3
    "dont use that harsh white line on folds
    hi Folded ctermbg=0
    hi Folded ctermfg=3
    "Finally get some decent comment colors
    hi Comment ctermfg=darkgreen
    "enable syntax processing
    syntax enable
    filetype plugin indent on
    set modeline
    "enable folding
    set foldenable
    "close all folds when opening file
    set foldlevelstart=0
    "fold based on syntax
    set foldmethod=syntax
    "search as I type
    set incsearch
    "highlight all matches
    set hlsearch
"}}}


""""""""""
"Mappings"
""""""""""
"{{{
    "Ctrl-S to save
    "inoremap <c-s> <esc>:w<cr>
    "nnoremap <c-s> :w<cr>
    "Ctrl-Q to exit in insert mode
    "inoremap <c-q> <esc>:q<cr>
    "nnoremap <c-q> :q<cr>
    "STOP USING ARROW KEYS
    "double remapped because they still work in insert and I bump them
    noremap <up> <nop>
    noremap <down> <nop>
    noremap <left> <nop>
    noremap <right> <nop>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>
    "further killing of arrow keys to stop 'O' lag
    set noesckeys
    "use <space> to turn off highlighting after search
    nnoremap <space> :nohl<cr>
    "quick indent
    "nnoremap <tab> I<tab><esc>
    "quick un-indent
    "nnoremap <shift><tab> I<BS><esc>
    "same but for blank line
    "nnoremap <return> o<esc>
    "I'm sick of bumping s and S, I never use them
    "nnoremap s <nop>
    "nnoremap S <nop>
    "quick makes
    inoremap <F5> <esc>:make<cr>
    nnoremap <F5> :make<cr>
    "source vimrc quickly
    nnoremap VR :source ~/.vimrc<cr>
    "kill F1 help uselessness
    noremap <F1> <nop>
    inoremap <F1> <nop>
    "line-by-line undo tree granularity
    inoremap <cr> <C-g>u<cr>
    "enter/exit hex mode
    noremap <leader>hx :%!xxd<cr> :set binary<cr>
    noremap <leader>nhx :%!xxd -r<cr>
    "make capital Y work like capital C and D
    nnoremap Y y$
    "for easy pane movement
    noremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l
    "Tab for autocomplete
    "inoremap <leader><Tab> <C-N>
    " vim-tmux-navigator
    let g:tmux_navigator_no_mappings = 1
    inoremap <silent> <C-h> <esc>:TmuxNavigateLeft<cr>
    noremap  <C-h> :TmuxNavigateLeft<cr>
    inoremap <silent> <C-j> <esc>:TmuxNavigateDown<cr>
    noremap  <C-j> :TmuxNavigateDown<cr>
    inoremap <silent> <C-k> <esc>:TmuxNavigateUp<cr>
    noremap  <C-k> :TmuxNavigateUp<cr>
    inoremap <silent> <C-l> <esc>:TmuxNavigateRight<cr>
    noremap  <C-l> :TmuxNavigateRight<cr>
    "inoremap <silent> <C-/> <esc>:TmuxNavigatePrevious<cr>i
    "nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>
    let g:tmux_navigator_save_on_switch = 0
    let g:tmux_navigator_disable_when_zoomed = 1
"}}}

"""""""""""""""
"Misc Settings"
"""""""""""""""
"{{{
    " ignore Vi compat
    set nocompatible
    " Pathogen
    execute pathogen#infect()
    "set format options specifically AFTER loading filetypes
    au FileType * set fo+=t fo+=c fo+=r fo+=w fo+=n fo+=l fo+=j
    au FileType * set fo-=o fo-=q fo-=a fo-=2 fo-=v fo-=b fo-=m fo-=M fo-=B fo-=1
    set textwidth=72
"}}}

" vim: set foldmethod=marker:
