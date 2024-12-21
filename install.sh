#!/bin/bash

# Crear el directorio de configuración de Neovim si no existe
mkdir -p ~/.config/nvim

# Descargar nvim-plug
echo "Descargando nvim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Crear el archivo init.vim
echo "Creando el archivo init.vim..."
cat <<EOL > ~/.config/nvim/init.vim
" ===============================
" Gestor de plugins: vim-plug
" ===============================
call plug#begin('~/.vim/plugged')

" Plugins esenciales para Python
Plug 'neoclide/coc.nvim', {'branch': 'release'}      " Autocompletado y LSP
Plug 'gruvbox-community/gruvbox'                    " Tema visual
Plug 'hoob3rt/lualine.nvim'                         " Barra de estado
Plug 'windwp/nvim-autopairs'                        " Cierre automático de (), {}, []

call plug#end()

" ===============================
" Configuración general
" ===============================
syntax enable
set background=dark
set number                              " Mostrar números de línea
set norelativenumber                    " Usar números absolutos
set cursorline                          " Resaltar línea actual
set signcolumn=yes                      " Mostrar columna para diagnósticos
set completeopt=menuone,noinsert,noselect  " Opciones de autocompletado

" Tema gruvbox
set background=dark
colorscheme gruvbox

" ===============================
" Configuración de coc.nvim
" ===============================
let g:coc_global_extensions = ['coc-pyright']

" Atajos para coc.nvim
nmap <silent> gd <Plug>(coc-definition)         " Ir a la definición
nmap <silent> gr <Plug>(coc-references)        " Buscar referencias
nmap <silent> K :call CocActionAsync('doHover')<CR> " Información flotante
nmap <leader>rn <Plug>(coc-rename)             " Renombrar variable
nmap <leader>f <Plug>(coc-format-selected)     " Formatear archivo
nnoremap <silent> [d <Plug>(coc-diagnostic-prev) " Ir al error anterior
nnoremap <silent> ]d <Plug>(coc-diagnostic-next) " Ir al siguiente error

" Autocompletado con Tab en coc.nvim
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" ===============================
" Configuración de lualine
" ===============================
lua <<EOF
require('lualine').setup({
  options = {
    theme = 'gruvbox',
    section_separators = {'', ''},
    component_separators = {'', ''},
  }
})
EOF

" ===============================
" Configuración de nvim-autopairs
" ===============================
lua <<EOF
require('nvim-autopairs').setup({})
EOF
EOL

echo "Instalación completada. Abre Neovim y ejecuta :PlugInstall para instalar los plugins."

