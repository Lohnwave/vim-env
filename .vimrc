"augroup filetype
"    autocmd! BufRead,BufNewFile BUILD set filetype=blade
"augroup end
set encoding=utf-8
filetype on
filetype plugin on
filetype indent on
set pyxversion=3
let g:python3_host_prog = '/usr/bin/python3.9'
set syntax=on
syntax enable
set nu
set hlsearch
" 禁止光标闪烁
set gcr=a:block-blinkon0
" 总是显示状态栏
set laststatus=2
" file encoding
set fileencodings=ucs-bom,utf-8-bom,utf-8,cp936,big5,gb18030,ucs
let g:fencview_autodetect = 1

let c_gnu=1
" 显示tab和空格
set listchars=tab:>-,trail:-
set list

" 显示光标当前位置
set ruler
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 实时搜索
set incsearch
set ignorecase
" 不使用兼容模式
set nocompatible
" 自动补全
set wildmenu
" 禁止折行
set nowrap
" 显示命令
set showcmd
" 显示匹配的括号
set showmatch
" 自动缩进
set autoindent
set cinoptions=e2
" tab
set tabstop=2
set expandtab
set shiftwidth=2
set smartindent

set autoread
set mouse-=a

" 修改leader键
let mapleader=','
let g:mapleader=','
" 保存后自动生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
set rtp+=~/.vim/bundle/onedark.vim
" 设置color
let g:onedark_terminal_italics = 1
let g:onedark_termcolors = 256
colorscheme onedark
set background=light
"let g:molokai_original = 1
   
" 切换前后buffer
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
" 设置真彩显示
set t_Co=256
" Plugin
set rtp+=~/.vim/bundle/nerdtree
set rtp+=~/.vim/bundle/vim-airline
set rtp+=~/.vim/bundle/vim-airline-themes
set rtp+=~/.vim/bundle/nvim-yarp
set rtp+=~/.vim/bundle/vim-hug-neovim-rpc
set rtp+=~/.vim/bundle/languageclient-neovim
set rtp+=~/.vim/bundle/deoplete.nvim
set rtp+=~/.vim/bundle/asyncrun.vim
set rtp+=~/.vim/bundle/LeaderF
set rtp+=~/.vim/bundle/vim-cpp-enhanced-highlight
" NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" vim-airline
let g:airline_theme="kolor"
let g:airline_detect_spell=1
let g:airline_detect_modified=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='jsformatter'
let g:airline_symbols_ascii = 0
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
" leaderf文件快速查找，函数列表等
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WindowPosition = 'popup'
let g:Lf_WindowHeight = 0.3
let g:Lf_TabpagePosition = 2
let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_PreviewCode = 1
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_RootMarkers = ['BLADE_ROOT', '.root', '.git']
let g:Lf_ReverseOrder = 1
let g:Lf_PopupColorscheme = 'gruvbox_material'
noremap <leader>f :LeaderfSelf<cr>
noremap <leader>fm :LeaderfMru<cr>
noremap <leader>ff :LeaderfFunction<cr>
noremap <leader>fb :LeaderfBufTagAll<cr>
noremap <leader>ft :LeaderfBufTag<cr>
noremap <leader>fl :LeaderfLine<cr>
noremap <leader>fw :LeaderfWindow<cr>
" asyncrun 异步执行shell命令
let g:asyncrun_open = 10
nnoremap <F10> :call asyncrun#quickfix_toggle(16)<cr>
let g:asyncrun_rootmarks = ['BLADE_ROOT', '.svn', '.git', '.root']
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
" 设置alias
call SetupCommandAlias("ar","AsyncRun")
" vim-cpp-enhanced-highlight – cpp高亮
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
" rainbow – 括号彩色
let g:rainbow_active=1
" deoplete 自动补全
let g:deoplete#enable_at_startup = 1
" 用户输入至少两个字符时再开始提示补全
call deoplete#custom#source('LanguageClient',
      \ 'min_pattern_length',
      \ 2)
" 字符串中不补全
call deoplete#custom#source('_',
      \ 'disabled_syntaxes', ['String']
      \ )
" 补全结束或离开插入模式时，关闭预览窗口 
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" 为每个语言定义completion source
" " 是的vim script和zsh script都有，这就是deoplete
call deoplete#custom#option('sources', {
      \ 'cpp': ['LanguageClient'],
      \ 'c': ['LanguageClient'],
      \ 'vim': ['vim'],
      \ 'zsh': ['zsh']
      \})
call deoplete#custom#option({
      \ 'auto_complete_delay': 200,
      \ 'smart_case': v:true,
      \ 'ignore_sources':{
      \ '-':['buffer', 'around']
      \ },
      \ })
set shortmess+=c
autocmd CompleteDone * silent! pclose!
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction
" LanguageClient
set hidden
let g:LanguageClient_serverCommands = {
      \ 'cpp': ['clangd'],
      \ }
let g:LanguageClient_rootMarkers = {
      \ 'cpp': ['BLADE_ROOT', '.git', 'compile_commands.json'],
      \ 'c': ['BLADE_ROOT', '.git', 'compile_commands.json'],
      \}
set formatexpr=LanguageClient_textDocument_rangeFormatting()
let g:LanguageClient_selectionUI='quickfix'
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<tab>"
nmap <silent><F5> <Plug>(lcn-menu)
nmap <silent><Leader>h <Plug>(lcn-hover)
nmap <silent><Leader>b <Plug>(lcn-definition)
nmap <silent><Leader>r <Plug>(lcn-references)
nmap <silent><Leader>t <Plug>(lcn-type-definition)
nmap <silent><Leader>i <Plug>(lcn-implementation)
nmap <silent><Leader>l <Plug>(lcn-symbols)
nmap <silent><Leader>nt <Plug>(lcn-diagnostics-next)
nmap <silent><Leader>pr <Plug>(lcn-diagnostics-prev)

" Language client airline
let g:airline#extensions#languageclient#enabled = 1
let airline#extensions#languageclient#error_symbol = 'E:'
let airline#extensions#languageclient#warning_symbol = 'W:'
let airline#extensions#languageclient#show_line_numbers = 1
let airline#extensions#languageclient#open_lnum_symbol = '(L'
let airline#extensions#languageclient#close_lnum_symbol = ')'

let g:AutoPairsFlyMode = 1
" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'popup'
set noshowmode
