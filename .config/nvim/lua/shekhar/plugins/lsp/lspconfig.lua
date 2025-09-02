return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Define diagnostic signs with icons
    local signs = {
      Error = "󰅚 ",
      Warn = "󰀪 ",
      Hint = "󰌶 ",
      Info = "󰋽 ",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
---@diagnostic disable-next-line: undefined-global
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local keymap = vim.keymap
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure diagnostics with proper settings to avoid duplicates
    vim.diagnostic.config({
      virtual_text = {
        spacing = 2,
        prefix = "●",
        source = "if_many",
        severity = { min = vim.diagnostic.severity.HINT },
      },
      signs = {
        severity = { min = vim.diagnostic.severity.HINT },
      },
      underline = {
        severity = { min = vim.diagnostic.severity.WARN },
      },
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        format = function(diagnostic)
          return string.format("%s: %s", diagnostic.source or "LSP", diagnostic.message)
        end,
      },
    })

    -- Suppress duplicate diagnostics from multiple sources
    local function filter_diagnostics(diagnostics)
      local filtered = {}
      local seen = {}
      
      for _, diagnostic in ipairs(diagnostics) do
        -- Create unique key based on line, column, message, and severity
        local key = diagnostic.lnum .. ":" .. diagnostic.col .. ":" .. diagnostic.message .. ":" .. diagnostic.severity
        if not seen[key] then
          seen[key] = true
          table.insert(filtered, diagnostic)
        end
      end
      
      return filtered
    end

    -- Apply diagnostic filtering globally
    local original_set = vim.diagnostic.set
    vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
      diagnostics = filter_diagnostics(diagnostics or {})
      return original_set(namespace, bufnr, diagnostics, opts)
    end

    -- LSP Server Configurations
    lspconfig.svelte.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    lspconfig.graphql.setup({
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    lspconfig.eslint.setup({
      capabilities = capabilities,
      settings = {
        packageManager = "npm",
        format = true, -- Enable ESLint formatting
        quiet = false,
        onIgnoredFiles = "off",
        run = "onType", -- Check while typing
        validate = "on",
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = "separateLine",
          },
          showDocumentation = { enable = true },
        },
        codeActionOnSave = {
          enable = true,
          mode = "all", -- Fix all auto-fixable issues
        },
      },
      on_attach = function(client, bufnr)
        -- Enable auto-fix on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.code_action({
              context = {
                only = { "source.fixAll.eslint" },
                diagnostics = {},
              },
              apply = true,
            })
          end,
        })
      end,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { 
            globals = { "vim" },
            disable = { 
              "missing-fields",
              "trailing-space",  -- Disable trailing space warnings
              "empty-line",      -- Disable empty line warnings
            },
          },
          completion = { callSnippet = "Replace" },
          workspace = {
            checkThirdParty = false,
          },
          format = {
            enable = false, -- Let other formatters handle this
          },
        },
      },
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = { unusedparams = true, shadow = true },
          staticcheck = true,
          completeUnimported = true,
          usePlaceholders = true,
          gofumpt = true,
        },
      },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
            for _, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
                end
              end
            end
          end,
        })
      end,
    })

    lspconfig.clangd.setup({
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      capabilities = vim.tbl_extend("force", capabilities, {
        offsetEncoding = { "utf-16" },
      }),
    })

    lspconfig.jdtls.setup({
      capabilities = capabilities,
      settings = {
        java = {
          configuration = { updateBuildConfiguration = "interactive" },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
            },
          },
          sources = {
            organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
          },
        },
      },
    })

    lspconfig.pyright.setup({
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })
  end,
}
