-- Material Theme Icons for nvim-web-devicons
-- VS Code Material Icon Theme style - minimal, colorful, geometric
local icons = {
	default = true,
	override = {
		-- Languages - Clean geometric shapes
		["go"] = { icon = "", color = "#00ADD8", name = "Go" },
		["js"] = { icon = "", color = "#F7DF1E", name = "JavaScript" },
		["ts"] = { icon = "", color = "#3178C6", name = "TypeScript" },
		["jsx"] = { icon = "", color = "#61DAFB", name = "JSX" },
		["tsx"] = { icon = "", color = "#61DAFB", name = "TSX" },
		["py"] = { icon = "", color = "#3776AB", name = "Python" },
		["rs"] = { icon = "", color = "#CE422B", name = "Rust" },
		["java"] = { icon = "", color = "#ED8B00", name = "Java" },
		["c"] = { icon = "", color = "#A8B9CC", name = "C" },
		["cpp"] = { icon = "", color = "#00599C", name = "CPP" },
		["cs"] = { icon = "", color = "#239120", name = "CSharp" },
		["php"] = { icon = "", color = "#777BB4", name = "PHP" },
		["rb"] = { icon = "", color = "#CC342D", name = "Ruby" },
		["lua"] = { icon = "", color = "#2C2D72", name = "Lua" },
		["vim"] = { icon = "", color = "#019833", name = "Vim" },

		-- Web Technologies
		["html"] = { icon = "", color = "#E34F26", name = "HTML" },
		["css"] = { icon = "", color = "#1572B6", name = "CSS" },
		["scss"] = { icon = "", color = "#CF649A", name = "SCSS" },
		["sass"] = { icon = "", color = "#CF649A", name = "SASS" },
		["less"] = { icon = "", color = "#1D365D", name = "LESS" },
		["vue"] = { icon = "", color = "#4FC08D", name = "Vue" },
		["svelte"] = { icon = "", color = "#FF3E00", name = "Svelte" },

		-- Data & Config - Geometric shapes
		["json"] = { icon = "", color = "#CBCB41", name = "JSON" },
		["xml"] = { icon = "", color = "#E37933", name = "XML" },
		["yaml"] = { icon = "", color = "#CB171E", name = "YAML" },
		["yml"] = { icon = "", color = "#CB171E", name = "YAML" },
		["toml"] = { icon = "", color = "#9C4221", name = "TOML" },
		["ini"] = { icon = "", color = "#6D8086", name = "INI" },
		["cfg"] = { icon = "", color = "#6D8086", name = "Config" },

		-- Database
		["sql"] = { icon = "", color = "#336791", name = "SQL" },
		["db"] = { icon = "", color = "#336791", name = "Database" },

		-- Shell & Scripts
		["sh"] = { icon = "", color = "#4EAA25", name = "Shell" },
		["bash"] = { icon = "", color = "#4EAA25", name = "Bash" },
		["zsh"] = { icon = "", color = "#4EAA25", name = "Zsh" },
		["fish"] = { icon = "", color = "#4EAA25", name = "Fish" },
		["ps1"] = { icon = "", color = "#012456", name = "PowerShell" },

		-- Documents - Clean minimal icons
		["md"] = { icon = "", color = "#083FA1", name = "Markdown" },
		["txt"] = { icon = "", color = "#6D8086", name = "Text" },
		["pdf"] = { icon = "", color = "#FF5722", name = "PDF" },
		["doc"] = { icon = "", color = "#2B579A", name = "Word" },
		["docx"] = { icon = "", color = "#2B579A", name = "Word" },
		["readme"] = { icon = "", color = "#083FA1", name = "Readme" },
		["readme.md"] = { icon = "", color = "#083FA1", name = "Readme" },

		-- Containers & DevOps
		["dockerfile"] = { icon = "", color = "#384D54", name = "Docker" },
		["docker-compose.yml"] = { icon = "", color = "#384D54", name = "DockerCompose" },
		[".dockerignore"] = { icon = "", color = "#384D54", name = "DockerIgnore" },

		-- Git & Version Control - Minimal branch icon
		[".gitignore"] = { icon = "", color = "#E84E31", name = "GitIgnore" },
		[".gitattributes"] = { icon = "", color = "#E84E31", name = "GitAttributes" },
		[".gitmodules"] = { icon = "", color = "#E84E31", name = "GitModules" },

		-- Build & Package Managers
		["package.json"] = { icon = "", color = "#E8274B", name = "PackageJSON" },
		["package-lock.json"] = { icon = "", color = "#7A2048", name = "PackageLockJSON" },
		["yarn.lock"] = { icon = "", color = "#2C8EBB", name = "YarnLock" },
		["pnpm-lock.yaml"] = { icon = "", color = "#F69220", name = "PnpmLock" },
		["composer.json"] = { icon = "", color = "#885630", name = "Composer" },
		["Cargo.toml"] = { icon = "", color = "#CE422B", name = "Cargo" },
		["go.mod"] = { icon = "", color = "#00ADD8", name = "GoMod" },
		["go.sum"] = { icon = "", color = "#00ADD8", name = "GoSum" },
		["Makefile"] = { icon = "", color = "#427819", name = "Makefile" },
		["CMakeLists.txt"] = { icon = "", color = "#064F8C", name = "CMake" },

		-- Config Files - Gear icon variations
		[".env"] = { icon = "", color = "#ECD53F", name = "Env" },
		[".env.local"] = { icon = "", color = "#ECD53F", name = "EnvLocal" },
		[".env.example"] = { icon = "", color = "#ECD53F", name = "EnvExample" },
		[".editorconfig"] = { icon = "", color = "#E0E0E0", name = "EditorConfig" },
		[".prettierrc"] = { icon = "", color = "#56B3B4", name = "Prettier" },
		[".eslintrc.js"] = { icon = "", color = "#4B32C3", name = "ESLint" },
		[".eslintrc.json"] = { icon = "", color = "#4B32C3", name = "ESLint" },
		[".eslintrc"] = { icon = "", color = "#4B32C3", name = "ESLint" },
		["tsconfig.json"] = { icon = "", color = "#3178C6", name = "TSConfig" },
		["webpack.config.js"] = { icon = "", color = "#8DD6F9", name = "Webpack" },
		["vite.config.js"] = { icon = "", color = "#646CFF", name = "Vite" },
		["vite.config.ts"] = { icon = "", color = "#646CFF", name = "Vite" },

		-- Framework specific
		["next.config.js"] = { icon = "", color = "#000000", name = "NextJS" },
		["nuxt.config.js"] = { icon = "", color = "#00C58E", name = "NuxtJS" },
		["svelte.config.js"] = { icon = "", color = "#FF3E00", name = "SvelteConfig" },

		-- Neovim specific
		["init.lua"] = { icon = "", color = "#51A0CF", name = "InitLua" },
		["init.vim"] = { icon = "", color = "#019833", name = "InitVim" },

		-- Archives & Binaries
		["zip"] = { icon = "", color = "#F9DC3E", name = "Archive" },
		["tar"] = { icon = "", color = "#F9DC3E", name = "Archive" },
		["gz"] = { icon = "", color = "#F9DC3E", name = "Archive" },
		["rar"] = { icon = "", color = "#F9DC3E", name = "Archive" },
		["7z"] = { icon = "", color = "#F9DC3E", name = "Archive" },

		-- Images - Simple geometric shapes
		["jpg"] = { icon = "", color = "#F44336", name = "Image" },
		["jpeg"] = { icon = "", color = "#F44336", name = "Image" },
		["png"] = { icon = "", color = "#F44336", name = "Image" },
		["gif"] = { icon = "", color = "#F44336", name = "Image" },
		["svg"] = { icon = "", color = "#FFB13B", name = "SVG" },
		["ico"] = { icon = "", color = "#F44336", name = "Icon" },
		["webp"] = { icon = "", color = "#F44336", name = "WebP" },

		-- Audio & Video
		["mp3"] = { icon = "", color = "#FF6B35", name = "Audio" },
		["wav"] = { icon = "", color = "#FF6B35", name = "Audio" },
		["mp4"] = { icon = "", color = "#FF6B35", name = "Video" },
		["avi"] = { icon = "", color = "#FF6B35", name = "Video" },

		-- Default fallbacks
		[""] = { icon = "", color = "#6D8086", name = "Default" },
	},
}

return icons
