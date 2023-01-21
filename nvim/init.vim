""""""""""""""""""""""""""""""""""""
" __  __        __     _____ __  __ 
"|  \/  |_   _  \ \   / /_ _|  \/  |
"| |\/| | | | |  \ \ / / | || |\/| |
"| |  | | |_| |   \ V /  | || |  | |
"|_|  |_|\__, |    \_/  |___|_|  |_|
"        |___/
"
""""""""""""""""""""""""""""""""""""
"add by youzhilane
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
"display
Plug 'vim-airline/vim-airline'
Plug 'tomasr/molokai'
"file dir tree
Plug 'preservim/nerdtree'
"代码补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dhruvasagar/vim-table-mode', {'for': ['markdown', 'vim-plug']}
"dart: for filetype detection and syntax highlighting"
Plug 'dart-lang/dart-vim-plugin'
call plug#end ()



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" common setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"补全时菜单排序展示
set wildmenu

"文件类型检测和文件缩紧文件装载
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
"tabstop 选项只修改 tab 字符的显示宽度，不修改按 Tab 键的行为
set tabstop=2
"expandtab 选项把插入的 tab 字符替换成特定数目的空格。具体空格数目跟 tabstop 选项值有关
set expandtab
"softtabstop 选项修改按 Tab 键的行为，不修改 tab 字符的显示宽度。具体行为跟 tabstop 选项值有关
set softtabstop=2
"自动缩进所使用的空白长度指示的。
set shiftwidth=2

"开启鼠标
set mouse=a

set encoding=utf-8

"行首按退格键能到上一行尾
set backspace=indent,eol,start
"折叠方法
set foldmethod=indent
set foldlevel=99
"normal和edit模式下光标效果区分
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"vim以当前文件的目录为工作目录
set autochdir

"打开文件时光标保持在上次编辑位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"16进制切换
map tx :%!xxd<CR>
map to :%!xxd -r<CR>

set clipboard=unnamed

"设定timeout，避免esc需要按两次
set timeoutlen=300

"设置Leader
let mapleader=" "

"placehodler
map <LEADER><LEADER> <ESC>/<++><CR>:nohlsearch<CR>c4l

"copy data between different vim instance
vmap <LEADER>y :w! /tmp/neovimtmp<CR>
nmap <LEADER>p :r! cat /tmp/neovimtmp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
"终端支持256种颜色
set t_Co=256
hi Visual ctermbg=30

set number
set rnu
set wrap
"当前行显示高亮线
set cursorline
"展示输入的命令
set showcmd
"适配解决不同环境color问题
let &t_ut=''
set list
set listchars=tab:▸\ ,trail:▫
"光标下方总是保留5行展示
set scrolloff=5
"vim默认为vim配置脚本设置了textwidth为78,当输入超过78个字符并按下空格键时会自动换行.将textwidth设成0关闭该功能
set tw=0
"缩进风格
set indentexpr=

"语法高亮
syntax on

"总是显示状态行
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save and quit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map S :w<CR>
map s <nop>
map Q :q<CR>
map R :source ~/.config/nvim/init.vim<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"高亮显示/的搜索到的内容
set hlsearch
"光标立刻跳转到/的搜索到的内容
set incsearch
exec "nohlsearch"
"搜索大小写敏感
set ignorecase
"搜索大小写智能匹配
set smartcase
"配置空格回车触发关闭/的搜索高亮
noremap <LEADER><CR> :nohlsearch<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" split & tabe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置光标位置并分屏
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>

"分屏间光标移动
map <LEADER>l <C-W>l
map <LEADER>k <C-w>k
map <LEADER>h <C-w>h
map <LEADER>j <C-W>j

"主分屏分屏大小调整
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

"垂直分屏和水平分屏相互切换
map sv <C-w>t<C-w>H
map snv <C-w>t<C-w>K

"tab新建和tab切换
map ta :tabe<CR>
map th :-tabnext<CR>
map tl :+tabnext<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ? for help
map tt :NERDTree<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown plugin: markdown-preview.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
   \ 'mkit': {},
   \ 'katex': {},
   \ 'uml': {},
   \ 'maid': {},
   \ 'disable_sync_scroll': 0,
   \ 'sync_scroll_type': 'middle',
   \ 'hide_yaml_meta': 1,
   \ 'sequence_diagrams': {},
   \ 'flowchart_diagrams': {},
   \ 'content_editable': v:false,
   \ 'disable_filename': 0,
   \ 'toc': {}
   \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'light'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown plugin: vim-table-mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:table_mode_corner='|'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown : key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> <c-e> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> ,m - [ ] 
autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc插件配置
" coc-flutter-tools: flutter plugin
" coc-go: golps extensions
let g:coc_global_extensions = [ 
  \ 'coc-marketplace', 
  \ 'coc-json', 
  \ 'coc-vimlsp', 
  \ 'coc-flutter-tools',
  \ 'coc-go'] 

" 允许未保存的vim文件暂存到缓冲区
set hidden

set updatetime=100

" tab补全
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" 按<CR>确认
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"在光标处打开自动补全
inoremap <silent><expr> <c-space> coc#refresh()

" 上下跳转到最近的语法错误
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 代码跳转
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 查看文档
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" 相同标识符高亮展示
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" 重命名
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" 格式化代码
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"代码折叠
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 待验证
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" 自动修复
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

"CodeLens是VS Code的一个功能，它可通过代码旁边的链接提供上下文感知的操作。 当VS Code在代码中检测到测试注释时，它将在注释旁边提供“Run Test”链接和“Debug Test”链接，以便您快速进行操作而不需跳出代码。
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
  "nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  "nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  "inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  "inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  "vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  "vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"CocConfig
"Coc snipis
