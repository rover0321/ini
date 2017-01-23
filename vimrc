"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme default
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM TRICKY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Ctrl+p: show prompt
"  Ctrl+v, I, esc: block insert
"  Ctrl+v, A, esc: block append
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nu
" syntax on
hi Comment ctermfg=lightgreen
set tabstop=4
set expandtab
set autowrite
set smartindent
set softtabstop=4
set history=99
set ignorecase                  " set noignorecase
set nocp                        " set nocompatible
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set showmatch                   " show match of (, [ and }
set matchtime=2                 " time of show match
set showcmd                     " show cmd in normal model
set incsearch                   " do incremental searching
set textwidth=80                " wrap comments"
set hls                         " hilight search

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set autoindent
set cindent shiftwidth=4
filetype indent on

" for wraped long line, gk/gj could k/j all the lines.
map <Up>   gk
map <Down> gj
" set encoding to automatically recognize file encoding and display it properly
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PYTHON PLUGIN SETTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"pydiction 1.2 python auto complete"
filetype plugin on
let g:pydiction_location = "~/.vim/plugin/complete-dict"
"default g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAGLIST SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on

" taglist settings
let Tlist_Auto_Open=0
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
let Tlist_WinWidth=32
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"

" map, remap for all model
" noremap, nmap, nnoremap for normal model
" vmap, vnoremap for virtual model
" xmap, xnoremap for X model, GUI
"
" keymap Ctrl+n to select next window
nnoremap <C-N> :next<return>
nnoremap <C-P> :previous<return>
inoremap <C-D> <esc>ddi
nnoremap <C-D> dd
nnoremap <F5> <C-W>w
nnoremap <F6> :Tlist<return>
nnoremap <F7> <C-W>q
nnoremap <S-F7> :A<return>
nnoremap <F12> :qall<return>
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-T> :NERDTree<return>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LOOKUP PLUGIN SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set lookupfiles options
let g:LookupFile_MinPatLength = 3
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0

" ~/.cscope is created by spd cmd
" filelist is created by sbe cmd
if filereadable("/home/johnson/.cscope/filelist")
    let g:LookupFile_TagExpr = '"/home/johnson/.cscope/filelist"'
endif

" lookup file in specified tag file
nmap <silent> <leader>lt :LUTags<cr>
" lookup buffer in all buffers loaded by vim
nmap <silent> <leader>lb :LUBufs<cr>
" lookup in specified dir
nmap <silent> <leader>lw :LUWalk<cr>
" http://www.vim.org/scripts/script.php?script_id=1581
"   LookupFile
"   LUPath
"   LUBufs
"   LUWalk
"   LUArgs
"
" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc' 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
