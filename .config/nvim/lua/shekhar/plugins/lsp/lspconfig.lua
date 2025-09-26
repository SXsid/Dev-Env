return {
	"neovim/nvim-lspconfig",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	dependencies = {
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")

		require("mason").setup()

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = { "lua_ls", "gopls", "ts_ls", "bashls" }, -- Fixed: changed tsserver to ts_ls
		})
		local mason_tool_installer = require("mason-tool-installer")
		require("neodev").setup({})
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			-- To jump back, press <C-T>.
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			-- Add formatting keymap
			opts.desc = "Format file or range (in visual mode)"
			keymap.set({ "n", "v" }, "<leader>mp", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					vim.keymap.set("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, { desc = "[T]oggle Inlay [H]ints", buffer = event.buf })
				end
			end,
		})

		vim.lsp.inlay_hint.enable(true)

		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "always" }, -- Show source to differentiate between LSP and linter
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = "󰠠 ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			} or {},
			virtual_text = {
				source = "always", -- Show source to see which tool reported the diagnostic
				spacing = 2,
				format = function(diagnostic)
					return string.format("[%s] %s", diagnostic.source or "unknown", diagnostic.message)
				end,
			},
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local def_capabilities = cmp_nvim_lsp.default_capabilities()

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- js formatter
				"stylua", -- lua formatter
				"clang-format", -- c++ formatter
				"eslint_d", -- js linter
				"golangci-lint", -- go linter
				"gofumpt", -- go formatter (better than gofmt)
				"goimports", -- go imports organizer
			},
		})
		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"clangd",
				"tailwindcss",
				"lua_ls",
				"ts_ls", -- Fixed: consistent naming
				"volar", -- Vue.js
				"bashls",
				"gopls",
				"pyright",
				"astro", -- Added: Astro support
			},
		})

		vim.lsp.config("*", {
			-- any custom settings...
		})

		-- C/C++ Language Server
		lspconfig.clangd.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--clang-tidy",
				"--background-index",
				"--malloc-trim",
				"--offset-encoding=utf-8",
				"--fallback-style=WebKit",
				"--log=verbose",
			},
		})

		-- Lua Language Server
		lspconfig.lua_ls.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim", "require" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		-- Go Language Server
		lspconfig.gopls.setup({
			capabilities = def_capabilities,
			on_attach = on_attach, -- ADDED this back to get keymaps for Go files
			settings = {
				gopls = {
					gofumpt = true,
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					hints = {
						assignVariableTypes = false,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						-- Keep only essential analyses to avoid conflicts with golangci-lint
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					usePlaceholders = true,
					completeUnimported = true,
					staticcheck = false, -- Disable to avoid conflict with golangci-lint
					directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					semanticTokens = true,
				},
			},
		})

		-- TypeScript Language Server (NEW - This was missing!)
		lspconfig.ts_ls.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})

		-- Vue.js Language Server (using Volar)
		lspconfig.volar.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
		})

		-- Astro Language Server (NEW)
		lspconfig.astro.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
		})

		-- Tailwind CSS Language Server
		lspconfig.tailwindcss.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
		})

		-- Python Language Server
		lspconfig.pyright.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
		})

		-- Bash Language Server
		lspconfig.bashls.setup({
			capabilities = def_capabilities,
			on_attach = on_attach,
		})
	end,
}
