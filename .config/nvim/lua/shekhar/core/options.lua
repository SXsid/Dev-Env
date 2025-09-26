vim.cmd("let g:netrw_liststyle=3")

local opt = vim.opt

-- Show mode
opt.showmode = false
opt.cmdheight = 1
opt.laststatus = 3
opt.signcolumn = "auto"

-- File numbers
opt.relativenumber = true
opt.number = true
opt.scrolloff = 15

-- Tabs & indentation - Force consistent 4-space indentation
opt.tabstop = 4 -- Visual width of tab character
opt.softtabstop = 4 -- Number of spaces tab counts for while editing
opt.shiftwidth = 4 -- Size of an indent
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Copy indent from current line when starting new line
opt.smartindent = true -- Smart autoindenting when starting new line

-- Override filetype indentation
vim.cmd([[
  autocmd FileType * setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
]])

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false

-- Colorscheme
opt.termguicolors = true
opt.background = "dark"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true
