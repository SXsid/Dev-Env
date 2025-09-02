vim.cmd("let g:netrw_liststyle=3")
vim.opt.splitright = false


local opt = vim.opt
--show mode
opt.showmode = false
opt.cmdheight = 1
opt.laststatus = 3  
opt.signcolumn = "auto"
--file numbers
opt.relativenumber = true
opt.number = true

--tabs & indentation

opt.tabstop =2 -- it will give 2 spaces when pressed
opt.shiftwidth = 2 -- tab to get indent
opt.autoindent = true --consistent indetn accros inside
opt.expandtab = true -- conver tab command to spacs

opt.wrap = false


--search setting

opt.ignorecase=true
opt.smartcase=true 

--colorscheme


opt.termguicolors = true
opt.background = "dark"


--backspace

opt.backspace= "indent,eol,start"

--clipboard

opt.clipboard:append("unnamedplus")

--split windows

opt.splitright=true
opt.splitbelow=true
