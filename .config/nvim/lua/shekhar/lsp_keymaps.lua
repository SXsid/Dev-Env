local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
	opts.buffer = bufnr

	opts.desc = "Show LSP references"
	keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

	opts.desc = "Go to declaration"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show LSP definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	-- ... all your other keymaps ...

	opts.desc = "Format file or range (in visual mode)"
	keymap.set({ "n", "v" }, "<leader>mp", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

return on_attach
