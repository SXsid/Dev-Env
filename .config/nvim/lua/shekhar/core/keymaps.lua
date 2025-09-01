vim.g.mapleader = " "

local map = vim.keymap

--source the file 
map.set("n","<leader><CR>",":so $MYVIMRC<CR>")
--explorer
map.set("n","<leader>pv",":Vex!<CR>")
map.set("n","<leader>h",":nohl<CR>")

--window mangment
map.set("n","<leader>sv","<C-w>v",{desc = "split vertical"})
map.set("n","<leader>sh","<C-w>s",{desc = "split horizontal"})
map.set("n","<leader>se","<C-w>=",{desc = "make split equal"})
map.set("n","<leader>sx","<cmd>close<CR>",{desc = "close the current split"})
