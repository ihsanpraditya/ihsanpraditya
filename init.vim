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
Plug 'lervag/vimtex' " LaTeX engine
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'gillescastel/latex-snippets'         
Plug 'SirVer/ultisnips' " Snippet library
Plug 'jayli/vim-easycomplete'
" Plug 'honza/vim-snippets' " Set of Snippets for many languages

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

" Pengaturan NVim kaitannya dengan Terminal yang dipakai
" if $TERM =~ '^\(rxvt\|screen\|nsterm\|interix\|putty\)\(-.*\)\?$'
"     set notermguicolors
" elseif $TERM =~ '^\(tmux\|iterm\|vte\|gnome\)\(-.*\)\?$'
"     set termguicolors
" elseif $TERM =~ '^\(xterm\)\(-.*\)\?$'
"     if $XTERM_VERSION != ''
"         set termguicolors
"     elseif $KONSOLE_PROFILE_NAME != ''
"         set termguicolors
"     elseif $VTE_VERSION != ''
"         set termguicolors
"     else
"         set notermguicolors
"     endif
" endif

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
                \ 'Renamed'   :'➜', 
                \ 'Unmerged'  :'═', 
                \ 'Deleted'   :'✖', 
                \ 'Dirty'     :'✗', 
                \ 'Ignored'   :'☒', 
                \ 'Clean'     :'✔︎', 
                \ 'Unknown'   :'?', }

let NERDTreeShowLineNumbers=1

" TABULAR
" let g:tabular_loaded = 1


" PENGATURAN PLUGIN KEMAMPUAN

" VIMTEX
let g:vimtex_view_method = 'skim'
let g:vimtex_view_general_viewer = 'open'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_enabled=1
let g:vimtex_fold_enabled=1
let g:vimtex_view_skim_sync=1
let g:vimtex_view_skim_activate=1
let g:vimtex_view_skim_reading_bar=1
" let g:vimtex_view_skim_sync=1
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let maplocalleader = ","
nmap <F5> <Plug>(vimtex-compile-ss)
nmap <F6> <Plug>(vimtex-view)

" default vimtex latexmk compiler engine
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \}

" latexmk engine non continues compilation
let g:vimtex_compiler_latexmk = {
    \ 'continuous' : 0,
    \}    

" custom function for VIMTEX 
nnoremap <silent> K :call <sid>show_documentation()<cr>
function! s:show_documentation()
  if index(['vim', 'help'], &filetype) >= 0
    execute 'help ' . expand('<cword>')
  elseif &filetype ==# 'tex'
    VimtexDocPackage
  else
    call CocAction('doHover')
  endif
endfunction 

" TEX-CONCEAL
set conceallevel=2
" setlocal spell
" set spelllang=en_us
let g:tex_conceal='abdgm'
let g:tex_conceal_frac=1
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
hi Conceal ctermbg=NONE


" ULTISNIPS
" - https://github.com/nvim-lua/completion-nvim
" let g:UltiSnips#CanExpandSnippet=1
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Biar loading lebih ngebut
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

" VIM-EASYCOMPLETE
let g:easycomplete_tab_trigger="<C-space>"
let g:easycomplete_diagnostics_enable = 0
let g:easycomplete_lsp_checking = 0
let g:easycomplete_signature_enable = 0
nnoremap gr :EasyCompleteReference<CR>
nnoremap gd :EasyCompleteGotoDefinition<CR>
nnoremap rn :EasyCompleteRename<CR>
nnoremap gb :BackToOriginalBuffer<CR>

" EMMET
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

" MARKDOWN
" Disable folding
let g:vim_markdown_folding_disabled = 1
let g:Tex_AutoFolding = 0
set foldenable
set foldmethod=syntax
set foldcolumn=0
set foldlevel=1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = '/Applications/Firefox.app'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
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
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" PYTHON
let g:python3_host_prog = '/usr/local/bin/python3'

" PERL
" let g:perl_host_prog = '/usr/local/bin/perl'
let g:loaded_perl_provider = 0

" RUBY
let g:ruby_host_prog = '/Users/user/.rbenv/versions/3.0.3/bin/neovim-ruby-host'

" NODEJS
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

" VISUAL-MULTI
let g:VM_maps = {} 
let g:VM_maps["Add Cursor Up"]   = '<C-k>'
let g:VM_maps["Add Cursor Down"] = '<C-j>'
let g:VM_mouse_mappings = 1

" LIGHTLINE
let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
      \ }

" NUMBER
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" COLORSCHEME
set tgc " agar warna base15 nya nyala
colo base16-google-dark

" TRANSPARENT
" hi Normal ctermbg=NONE guibg=NONE 
" hi NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

" auto complete background color pink issue dan pengaturan warna lainnya
" hi Pmenu guifg=white guibg=Gray
" hi Tabline guifg=black
" hi PmenuSbar guifg=white
map <esc> :noh <CR>
syntax on

" FONT COLOR

" NON-GUI
" hi Comment cterm=italic ctermfg=DarkGray
" hi Normal ctermfg=Gray
" hi SpellBad cterm=NONE ctermfg=NONE ctermbg=NONE
" hi SpellLocal cterm=underlineline ctermbg=NONE

" GUI
hi Comment gui=italic guifg=Gray
hi Normal guifg=NONE

" FZF
set rtp+=/usr/local/opt/fzf


