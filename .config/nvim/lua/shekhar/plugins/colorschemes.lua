return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		lazy = false,
		config = function()
			vim.opt.termguicolors = true
			vim.opt.background = "dark"

			-- Gruvbox material base options
			vim.g.gruvbox_material_background = "soft"
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_disable_terminal_colors = 1
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_transparent_background = 1

			vim.cmd.colorscheme("gruvbox-material")

			local fg = "#d4be98" -- foreground
			local bg = "NONE" -- transparent background
			local bg_alt = "#1d2021" -- semi-transparent alternative

			-- Make everything transparent for background image
			local transparent_groups = {
				-- Core editor
				"Normal",
				"NormalNC",
				"NormalFloat",
				"NormalSB",
				-- Terminal
				"Terminal",
				"TermCursor",
				"TermCursorNC",
				-- UI Elements
				"SignColumn",
				"LineNr",
				"CursorLineNr",
				"EndOfBuffer",
				"VertSplit",
				"WinSeparator",
				"Folded",
				"FoldColumn",
				-- Status and tab lines
				"StatusLine",
				"StatusLineNC",
				"TabLine",
				"TabLineFill",
				"TabLineSel",
				-- Popups and menus
				"Pmenu",
				"PmenuSel",
				"PmenuSbar",
				"PmenuThumb",
				"FloatBorder",
				"NormalFloat",
				-- File explorer (if using netrw or nvim-tree)
				"Directory",
				"NetrwDir",
				"NvimTreeNormal",
				"NvimTreeEndOfBuffer",
				"NvimTreeVertSplit",
				"NvimTreeStatusLine",
				"NvimTreeStatusLineNC",
				-- Telescope
				"TelescopeNormal",
				"TelescopeBorder",
				"TelescopePromptBorder",
				"TelescopeResultsBorder",
				"TelescopePreviewBorder",
				-- Which-key
				"WhichKeyFloat",
				"WhichKeyBorder",
				-- Dashboard/Alpha
				"DashboardHeader",
				"DashboardCenter",
				"DashboardShortcut",
				"DashboardFooter",
				"AlphaHeader",
				"AlphaButtons",
				"AlphaShortcut",
				"AlphaFooter",
			}

			-- Apply transparency
			for _, group in ipairs(transparent_groups) do
				vim.api.nvim_set_hl(0, group, { bg = bg })
			end

			-- Special cases that need foreground preserved
			vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
			vim.api.nvim_set_hl(0, "NormalNC", { fg = fg, bg = bg })

			-- Optional: Semi-transparent backgrounds for better readability
			-- Uncomment these if full transparency is too hard to read
			-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#282828", blend = 20 })
			-- vim.api.nvim_set_hl(0, "Visual", { bg = "#504945", blend = 30 })
		end,
	},
}
