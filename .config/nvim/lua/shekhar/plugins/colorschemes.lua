return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- load before other plugins
    lazy = false,    -- make sure it loads on startup
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,      -- add terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,              -- invert background for search, diffs, etc.
        contrast = "",               -- empty for medium contrast between soft/hard
        palette_overrides = {
          bg0 = "#2e2e2e",           -- lighter gray background (similar to chat)
          bg1 = "#404040",           -- slightly lighter for contrast
          fg0 = "#f0f0f0",           -- brighter white text for better readability
          fg1 = "#e8e8e8",           -- slightly dimmer white
        },
        dim_inactive = false,
        overrides = {
          Normal       = { bg = "#2e2e2e", fg = "#f0f0f0" }, -- main editor
          NormalFloat  = { bg = "#404040", fg = "#f0f0f0" }, -- floating windows
          SignColumn   = { bg = "#2e2e2e" },                 -- gutter area
          LineNr       = { bg = "#2e2e2e", fg = "#888888" }, -- line numbers
          CursorLineNr = { bg = "#2e2e2e", fg = "#d79921", bold = true }, -- current line number
          CursorLine   = { bg = "#404040" },                 -- current line highlight
          Visual       = { bg = "#5a5a5a" },                 -- selection highlight
          Comment      = { fg = "#928374", italic = true },  -- comments
          String       = { fg = "#b8bb26", italic = true },  -- strings
          Function     = { fg = "#fabd2f", bold = true },    -- functions
          Keyword      = { fg = "#fb4934", bold = true },    -- keywords
          Type         = { fg = "#8ec07c" },                 -- types
          Identifier   = { fg = "#83a598" },                 -- identifiers
        },
        transparent_mode = false,    -- set true if you want transparent background
      })
      -- Apply the colorscheme
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}

