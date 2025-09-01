return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lazy_status = require("lazy.status")
      require("lualine").setup({
        options = {
          theme = "gruvbox",
        },
        sections = {
          lualine_x = {
            {
              lazy_status.updates, -- shows update count
              cond = lazy_status.has_updates, -- only show when updates exist
              color = { fg = "#ff9e64" }, -- orange highlight
            },
            "encoding",
            "fileformat",
            "filetype",
          },
        },
      })
    end,
  },
}

