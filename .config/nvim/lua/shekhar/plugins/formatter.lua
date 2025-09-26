return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Web
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },

				-- Lua
				lua = { "stylua" },

				-- Python
				python = { "isort", "black" },

				-- Go
				go = { "gofumpt" },

				-- C / C++
				c = { "clang-format" },
				cpp = { "clang-format" },

				-- Java
				java = { "google-java-format" },

				-- SQL
				sql = { "sql-formatter" },
			},

			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			},
		})

		-- Manual format keymap
		vim.keymap.set({ "n", "v" }, "<leader>if", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
