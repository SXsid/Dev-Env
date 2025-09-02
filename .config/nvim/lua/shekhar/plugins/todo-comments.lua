return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local todo_comments = require("todo-comments")
    
    todo_comments.setup()
    
    -- Load telescope extension
    local telescope_ok, telescope = pcall(require, "telescope")
    if telescope_ok then
      telescope.load_extension("todo-comments")
    end
    
    -- set keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>tn", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })
    keymap.set("n", "<leader>tp", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })
  end,
}
