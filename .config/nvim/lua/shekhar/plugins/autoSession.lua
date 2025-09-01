return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>AutoSession search<CR>", { desc = "search for session" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "save the current session" }) -- save workspace session for current working directory
    keymap.set("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "delete the session" }) -- save workspace session for current working directory
  end,
}
