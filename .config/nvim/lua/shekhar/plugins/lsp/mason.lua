return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")
    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- Frontend/Fullstack
        "ts_ls",        -- TypeScript/JavaScript
        "html",         -- HTML
        "cssls",        -- CSS
        "tailwindcss",  -- Tailwind CSS
        "svelte",       -- Svelte
        "emmet_ls",     -- Emmet
        "eslint",       -- ESLint
        
        -- Backend Core Languages
        "pyright",      -- Python
        "gopls",        -- Go
        "clangd",       -- C/C++
        "jdtls",        -- Java
        "rust_analyzer", -- Rust
        
        -- Databases & Query Languages
        "sqls",         -- SQL
        "graphql",      -- GraphQL
        "prismals",     -- Prisma
        
        -- Configuration & Infrastructure
        "yamlls",       -- YAML (Docker Compose, K8s, CI/CD)
        "jsonls",       -- JSON
        "dockerls",     -- Dockerfile
        "bashls",       -- Bash/Shell scripts
        "lua_ls",       -- Lua (for Neovim config)
        
        -- Protocol Buffers & gRPC
      },
    })
    mason_tool_installer.setup({
      ensure_installed = {
        -- Language Formatters
        "prettier",     -- JS/TS/JSON/YAML/CSS/HTML/GraphQL formatter
        "stylua",       -- Lua formatter
        "isort",        -- Python import formatter
        "black",        -- Python formatter
        "gofumpt",      -- Go formatter (better than gofmt)
        "clang-format", -- C/C++ formatter
        "sql-formatter", -- SQL formatter
        "google-java-format", -- Java formatter
        
        -- Linters & Analysis Tools
        "pylint",       -- Python linter
        "eslint_d",     -- JS/TS linter daemon
        "golangci-lint", -- Go linter
        "buf",          -- Protocol Buffers linter/formatter
        "yamllint",     -- YAML linter
        "shellcheck",   -- Shell script linter
        
        -- Additional Tools
        "hadolint",     -- Dockerfile linter
      },
    })
  end,
}
