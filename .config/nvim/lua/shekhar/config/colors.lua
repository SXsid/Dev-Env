-- lua/config/colors.lua
local M = {}

function M.setup()
	local colors = {
		bg0 = "#292828",
		bg1 = "#32302f",
		bg2 = "#383432",
		bg3 = "#45403d",
		bg4 = "#504945",
		bg5 = "#665c54",
		fg0 = "#d4be98",
		fg1 = "#ddc7a1",
		fg2 = "#c5b18d",
		fg3 = "#a89984",
		fg4 = "#928374",
		fg5 = "#7c6f64",
		red = "#ea6962",
		orange = "#e78a4e",
		yellow = "#d8a657",
		green = "#a9b665",
		aqua = "#89b482",
		blue = "#7daea3",
		purple = "#d3869b",
	}

	local highlights = {
		-- Core UI
		Normal = { fg = colors.fg0, bg = colors.bg0 },
		NormalNC = { fg = colors.fg0, bg = colors.bg0 }, -- inactive windows
		NormalFloat = { fg = colors.fg0, bg = colors.bg0 },
		SignColumn = { fg = colors.fg5, bg = colors.bg0 },
		EndOfBuffer = { fg = colors.bg0, bg = colors.bg0 }, -- fix tilde (~) lines
		VertSplit = { fg = colors.bg0, bg = colors.bg0 }, -- hide vertical splits

		Cursor = { fg = colors.bg0, bg = colors.fg0 },
		CursorLine = { bg = colors.bg1 },
		CursorLineNr = { fg = colors.fg4, bg = colors.bg1 },
		LineNr = { fg = colors.fg5 },
		Visual = { bg = colors.bg3 },

		-- Status line
		StatusLine = { fg = colors.fg3, bg = colors.bg0 },
		StatusLineNC = { fg = colors.fg5, bg = colors.bg0 },

		-- Tabs
		TabLine = { fg = colors.fg5, bg = colors.bg0 },
		TabLineFill = { fg = colors.fg5, bg = colors.bg0 },
		TabLineSel = { fg = colors.fg0, bg = colors.bg0 },

		-- Pmenu
		Pmenu = { fg = colors.fg0, bg = colors.bg2 },
		PmenuSel = { fg = colors.fg0, bg = colors.bg3 },
		PmenuSbar = { bg = colors.bg2 },
		PmenuThumb = { bg = colors.fg3 },

		-- Search
		Search = { fg = colors.bg0, bg = colors.orange },
		IncSearch = { fg = colors.bg0, bg = colors.green },

		-- Diagnostics
		DiagnosticError = { fg = colors.red },
		DiagnosticWarn = { fg = colors.yellow },
		DiagnosticInfo = { fg = colors.blue },
		DiagnosticHint = { fg = colors.aqua },

		-- Syntax
		Comment = { fg = colors.fg4, italic = true },
		Keyword = { fg = colors.red },
		Statement = { fg = colors.red },
		Conditional = { fg = colors.red },
		Repeat = { fg = colors.red },
		Label = { fg = colors.red },
		Exception = { fg = colors.red },

		StorageClass = { fg = colors.orange },
		Structure = { fg = colors.orange },
		Typedef = { fg = colors.orange },
		Operator = { fg = colors.orange },

		String = { fg = colors.yellow },
		Character = { fg = colors.yellow },

		Function = { fg = colors.green },
		Identifier = { fg = colors.green },

		Type = { fg = colors.blue },
		PreProc = { fg = colors.aqua },
		Include = { fg = colors.aqua },
		Define = { fg = colors.aqua },
		Macro = { fg = colors.aqua },

		Constant = { fg = colors.purple },
		Number = { fg = colors.purple },
		Boolean = { fg = colors.purple },
		Float = { fg = colors.purple },

		Special = { fg = colors.orange },
		Delimiter = { fg = colors.fg0 },

		Underlined = { underline = true },
		Error = { fg = colors.red },
		Todo = { fg = colors.yellow, bold = true },

		-- Git signs
		GitSignsAdd = { fg = colors.green },
		GitSignsChange = { fg = colors.blue },
		GitSignsDelete = { fg = colors.red },

		-- Treesitter
		["@keyword"] = { fg = colors.red },
		["@keyword.function"] = { fg = colors.red },
		["@keyword.operator"] = { fg = colors.orange },
		["@operator"] = { fg = colors.orange },
		["@punctuation.delimiter"] = { fg = colors.fg0 },
		["@punctuation.bracket"] = { fg = colors.fg0 },
		["@string"] = { fg = colors.yellow },
		["@string.escape"] = { fg = colors.green },
		["@function"] = { fg = colors.green },
		["@function.call"] = { fg = colors.green },
		["@variable"] = { fg = colors.fg0 },
		["@type"] = { fg = colors.blue },
		["@constant"] = { fg = colors.purple },
		["@number"] = { fg = colors.purple },
		["@boolean"] = { fg = colors.purple },
		["@comment"] = { fg = colors.fg4, italic = true },

		-- LSP semantic tokens
		["@lsp.type.class"] = { fg = colors.blue },
		["@lsp.type.enum"] = { fg = colors.purple },
		["@lsp.type.interface"] = { fg = colors.blue },
		["@lsp.type.namespace"] = { fg = colors.purple },
		["@lsp.type.type"] = { fg = colors.blue },
		["@lsp.type.variable"] = { fg = colors.fg0 },
		["@lsp.type.property"] = { fg = colors.fg0 },
		["@lsp.type.function"] = { fg = colors.green },
		["@lsp.type.method"] = { fg = colors.green },

		-- NvimTree full overrides
		NvimTreeNormal = { fg = colors.fg0, bg = colors.bg0 },
		NvimTreeNormalNC = { fg = colors.fg0, bg = colors.bg0 },
		NvimTreeEndOfBuffer = { fg = colors.bg0, bg = colors.bg0 },
		NvimTreeVertSplit = { fg = colors.bg0, bg = colors.bg0 },
		NvimTreeCursorLine = { bg = colors.bg1 },
		NvimTreeCursorColumn = { bg = colors.bg1 },
		NvimTreeRootFolder = { fg = colors.orange, bold = true },
		NvimTreeFolderName = { fg = colors.blue },
		NvimTreeFolderIcon = { fg = colors.blue },
		NvimTreeOpenedFolderName = { fg = colors.aqua },
		NvimTreeEmptyFolderName = { fg = colors.fg4 },
		NvimTreeExecFile = { fg = colors.green },
		NvimTreeOpenedFile = { fg = colors.fg0 },
		NvimTreeSpecialFile = { fg = colors.yellow },
		NvimTreeImageFile = { fg = colors.purple },
		NvimTreeMarkdownFile = { fg = colors.orange },
		NvimTreeIndentMarker = { fg = colors.bg4 },
		NvimTreeGitDirty = { fg = colors.orange },
		NvimTreeGitStaged = { fg = colors.green },
		NvimTreeGitMerge = { fg = colors.purple },
		NvimTreeGitRenamed = { fg = colors.purple },
		NvimTreeGitNew = { fg = colors.yellow },
		NvimTreeGitDeleted = { fg = colors.red },
		NvimTreeGitIgnored = { fg = colors.fg5 },
		NvimTreeWindowPicker = { fg = colors.bg0, bg = colors.yellow },
	}

	for group, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

return M
