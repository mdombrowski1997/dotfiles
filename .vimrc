"~/.vimrc - sourced when vim starts, vim personalizations

""""""""""""""""""""""""""""""""""""
"Colors, Personalizations, and Such"
""""""""""""""""""""""""""""""""""""
"{{{
    set nowrap
    "set colors
    set t_Co=256
    colorscheme elfking
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
    set nocursorline
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
    set timeout ttimeoutlen=100
    "use <space> to turn off highlighting after search
    nnoremap <space> :nohl<cr>
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
    " vim-tmux-navigator
    let g:tmux_navigator_no_mappings = 1
    noremap  <silent> <C-h> :TmuxNavigateLeft<cr>
    noremap  <silent> <C-j> :TmuxNavigateDown<cr>
    noremap  <silent> <C-k> :TmuxNavigateUp<cr>
    noremap  <silent> <C-l> :TmuxNavigateRight<cr>
    "nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>
    let g:tmux_navigator_save_on_switch = 0
    let g:tmux_navigator_disable_when_zoomed = 1
    " Compile  executable with <leader>m
    nnoremap <leader>m :make<cr>
    " Test executable with <leader>r
    " nnoremap <leader>r :!./exe<cr>
    " Spell checking easier
    nnoremap s ]s
    nnoremap S [s
    " LaTeX macros
    function! GetName()
        " Get user input
        call inputsave()
        let name = input('region name?: ')
        call inputrestore()
        " Print tags with input
        call setline('.', '\begin{' . name . '}')
    endfunction
    nnoremap <leader>c i\color{}<esc>i
    nnoremap <leader>r o<esc>:call GetName()<cr><esc>^yf}o<esc>p^lcwend<esc>O
    nnoremap <leader>s :set spell!<cr>
    nnoremap <leader>b i\textbf{}<esc>i
    nnoremap <leader>i i\textit{}<esc>i
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
    au FileType * set fo+=t fo+=c fo+=w fo+=n fo+=l fo+=j
    au FileType * set fo-=r fo-=o fo-=q fo-=a fo-=2 fo-=v fo-=b fo-=m fo-=M fo-=B fo-=1
    set textwidth=72
    set makeprg=make\ EXTRA_CFLAGS=-fdiagnostics-color=always 
    " Fix all this nonsensical fold changing
    autocmd InsertLeave,WinEnter * setlocal foldmethod=syntax
    autocmd InsertEnter,WinLeave * setlocal foldmethod=manual
"}}}

" vim: set foldmethod=marker:
