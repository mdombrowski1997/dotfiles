"~/.vimrc - sourced when vim starts, vim personalizations

""""""""""""""""""""""""""""""""""""
"Colors, Personalizations, and Such"
""""""""""""""""""""""""""""""""""""
"{{{
    "set colors
    colorscheme monokai
    "change tabs to be 4 spaces
    set tabstop=4
    set softtabstop=4
    set expandtab
    "show line numbers
    set number
    "show current line on
    set cursorline
    highlight CursorLine term=bold cterm=bold
    "redraw less often, faster maybe
    set lazyredraw
    "show matches to parentheses and such
    set showmatch
    "only show matches for 3 tenths of a sec
    set matchtime=3 
"}}}

"""""""""
"Folding"
"""""""""
"{{{
    "enable syntax processing
    filetype on
    syntax enable
    set modeline
    "enable folding
    set foldenable
    "close all folds when opening file
    set foldlevelstart=0
    "fold based on syntax
    set foldmethod=syntax
"}}}

"""""""""""""""""""""""""
"Searching and Registers"
"""""""""""""""""""""""""
"{{{
    "Searching and Registers"
    "make yank clipboard system clipboard
    set clipboard=unnamed
    "search as I type
    set incsearch
    "highlight all matches
    set hlsearch
"}}}

"""""""""""""""
"Misc Settings"
"""""""""""""""
"{{{
    "allow aliases in vim!
    set shellcmdflag=-ic
"}}}

""""""""""
"Mappings"
""""""""""
"{{{
    "Ctrl-S to save
    inoremap <c-s> <esc>:w<cr>
    nnoremap <c-s> :w<cr>
    "Ctrl-Q to exit in insert mode
    inoremap <c-q> <esc>:q<cr>
    nnoremap <c-q> :q<cr>
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
    "use <space> to turn off highlighting after search
    nnoremap <space> :nohl<cr>
    "quick indent
    nnoremap <tab> I<tab><esc>
    "same but for blank line
    "nnoremap <return> o<esc>
    "I'm sick of bumping s and S, I never use them
    nnoremap s <nop>
    nnoremap S <nop>
    "Y'all thought I wasn't in Visual Studio
    inoremap <F7> <esc>:!cl<cr>
    nnoremap <F7> :!cl<cr>
    "source vimrc quickly
    nnoremap VR :source ~/.vimrc<cr>
"}}}

""""""""""""""
"Autocommands"
""""""""""""""
"{{{
    "General actions for all files
    augroup general_cmds
        autocmd!
        "change foldmethod during insertion to prevention spontaneous unfolding
        autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
        "change back when leaving insert
        autocmd InsertLeave, WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
    augroup END

    "actions for c++ source files
    augroup filetype_cpp
        autocmd!
        "abbreviations for typo correction and such
        iabbrev #i #include
        iabbrev forl for (  )<cr><tab>{<cr><tab>}<esc>kk$hhi
    augroup END
"}}}

" vim: set foldmethod=marker:
