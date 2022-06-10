" Urutan plugin vim-plug.
" 1. Pengaturan editor bawaan. 
" 2. Pengaturan editor dengan plugin. 
" 3. Pengaturan plugin kemampuan.
" 4. Pengaturan tema. 
" vim-plug
call plug#begin('~/.config/nvim/plugged')
 
" Plugin File
Plug 'scrooloose/nerdtree' " Sebagai file explorer side bar.
Plug 'Xuyuanp/nerdtree-git-plugin' " Belum coba.

" Plugin Editor Teks dan Kode
Plug 'mattn/emmet-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Buat multi cursor
Plug 'godlygeek/tabular' " Buat ngelurusin, alignment, justify, dll.
Plug 'preservim/vim-markdown' 
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'sheerun/vim-polyglot' " Paket bahasa komputer, ada 598 paket bahasa, pendeteksi indentasi otomatis, dan pewarnaan sintaks bahasa.
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips' " snippet engine
Plug 'honza/vim-snippets' " Set of Snippets for many languages

" Others:
" Lean & mean status/tabline for vim that's light as air.
" Plug '/vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plugin Tema dan Kustomisasi
Plug 'itchyny/lightline.vim' " Memperindah status bar di bawah.
Plug 'altercation/vim-colors-solarized' " Tema
Plug 'tomasr/molokai' " Tema
Plug 'chriskempson/base16-vim' " Banyak tema
Plug 'NLKNguyen/papercolor-theme' " Tema inspirasi desain Google, load fast, mendukung mulai terminal 4-bit, juga syntax highlighting
call plug#end()

" PENGATURAN EDITOR BAWAAN

" noh - no highlight
map <esc> :noh <CR>
"set nowrap

" fix : backspace

" unknown
syntax on

" PENGATURAN EDITOR DENGAN PLUGIN
" NERDTree Configuration
nnoremap <C-t> :NERDTreeToggle<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" NERDTreeGit Configuration
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜', \ 'Unmerged'  :'═', \ 'Deleted'   :'✖', \ 'Dirty'     :'✗', \ 'Ignored'   :'☒', \ 'Clean'     :'✔︎', \ 'Unknown'   :'?', \ } " tabular configuration
" let g:tabular_loaded = 1


" PENGATURAN PLUGIN KEMAMPUAN
" Pengaturan Latex
" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'preview'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
" let g:vimtex_compiler_method = 'latexrun'

" Ganti ke Xelatex
" let g:vimtex_compiler_latexmk_engines = 'xelatex'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

" snippets
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Biar loading lebih ngebut
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']


" pengaturan emmet
"allow emmet in all mode
let g:user_emmet_mode='a'
 
" allow emmet for html and css only
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" redefining emmet key
let g:user_emmet_leader_key='<C-z>'

" Snippet to add meta tag for responsiveness
let g:user_emmet_settings = {
\  'variables': {'lang': 'ja'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

" Disable folding
let g:vim_markdown_folding_disabled = 1
let g:Tex_AutoFolding = 0
set foldenable
set foldmethod=syntax
set foldcolumn=0
set foldlevel=1
" set foldlevelstart=99

" MarkDown starts here
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
" default: ''
let g:mkdp_browser = '/Applications/Firefox.app'

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
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" example
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" python-conf-provider
" let g:python3_host_prog = '/usr/local/Cellar/python@3.10/3.10.1/bin/python3.10'
let g:python3_host_prog = '/usr/local/bin/python3'


" PENGATURAN TEMA
set t_Co=256
" set background=dark
:colorscheme base16-tomorrow-night
" PaperColor-theme
" this is the default configuration for PaperColor
" let g:PaperColor_Theme_Options = {
  " \   'theme': {
  " \     'default': {
  " \       'transparent_background': 1
  " \     }
  " \   }
  " \ }
" this is my configuration for PaperColor
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 1,
  \       'override' : {
  \         'color00' : ['#080808', '232'],
  \         'linenumber_bg' : ['#080808', '232']
  \       }
  \     }
  \   },
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
" base16
set termguicolors

" conf visual-multi
"let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps["Add Cursor Up"] = ''
let g:VM_maps["Add Cursor Up"] = '<C-k>'
let g:VM_maps["Add Cursor Down"] = '<C-j>'
"bingung apa nama dari cursor Up dan Down di Vim!?
"let g:VM_custom_remaps = {}
"let g:VM_custom_remaps = {'<C-k>': '<C-Up>'}
let g:VM_mouse_mappings = 1

" status bar, wombat, solarized, PaperColor, one
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
" Ngatur penomoran number relative di tampilan yang focus saja
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" transparent
hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

" use fzf in Nvim
set rtp+=/usr/local/opt/fzf
