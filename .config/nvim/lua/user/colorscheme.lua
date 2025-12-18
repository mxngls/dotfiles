-- Colorscheme configuration and customizations
--
-- This file handles:
--   1. macOS appearance sync (dark/light mode detection)
--   2. Rustdoc colorscheme setup
--   3. Custom overrides for "quiet" syntax style
--
-- Custom overrides from official rustdoc colors:
--   1. "Quiet" syntax style: functions, types, and properties use foreground color
--      instead of dedicated colors (official rustdoc uses green/orange for functions,
--      cyan/purple for types)
--   2. Light theme uses softer #24292e foreground instead of pure black

-- Detect macOS appearance and set background accordingly
local function sync_os_appearance()
	-- Only run on macOS
	if vim.fn.has("mac") ~= 1 and vim.fn.has("macunix") ~= 1 then
		return
	end

	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
	if handle then
		local result = handle:read("*a")
		handle:close()
		-- If the command succeeds and returns "Dark", we're in dark mode
		-- If it fails or returns empty, we're in light mode
		local new_bg = result:match("Dark") and "dark" or "light"
		if vim.o.background ~= new_bg then
			vim.o.background = new_bg
			-- Only reload colorscheme if it's already loaded
			if vim.g.colors_name then
				vim.cmd.colorscheme(vim.g.colors_name)
			end
		end
	end
end

-- Set initial background before loading colorscheme
sync_os_appearance()

-- Enable true colors and colorscheme settings
vim.opt.termguicolors = true
vim.g.rustdoc_light_use_backgrounds = true

-- Create command to manually sync with OS appearance
vim.api.nvim_create_user_command("SyncAppearance", sync_os_appearance, {
	desc = "Sync Neovim appearance with macOS system theme"
})

-- Automatically sync when Neovim gains focus
vim.api.nvim_create_autocmd("FocusGained", {
	callback = sync_os_appearance,
	desc = "Auto-sync appearance with macOS when gaining focus"
})

-- Custom overrides for rustdoc colorscheme
local function apply_rustdoc_overrides()
	local bg = vim.o.background

	-- Get foreground color based on theme
	local fg
	local fg_muted
	if bg == "dark" then
		fg = "#dddddd"
		fg_muted = "#b0b0b0" -- Muted gray for punctuation
	else
		-- Override 1: Use softer foreground (#24292e) instead of pure black
		fg = "#24292e"
		fg_muted = "#505050" -- Muted gray for punctuation

		-- Also update terminal colors for light theme
		vim.g.terminal_color_7 = "#24292e"
		vim.g.terminal_color_15 = "#24292e"
	end

	-- Override 2: "Quiet" syntax style - functions, types, and properties use foreground

	-- Basic syntax groups
	vim.api.nvim_set_hl(0, "Function", { fg = fg })
	vim.api.nvim_set_hl(0, "Type", { fg = fg })

	-- Treesitter - Functions
	vim.api.nvim_set_hl(0, "@function", { fg = fg })
	vim.api.nvim_set_hl(0, "@function.builtin", { fg = fg })
	vim.api.nvim_set_hl(0, "@function.call", { fg = fg })
	vim.api.nvim_set_hl(0, "@function.method", { fg = fg })
	vim.api.nvim_set_hl(0, "@function.method.call", { fg = fg })
	vim.api.nvim_set_hl(0, "@constructor", { fg = fg })

	-- Treesitter - Types
	vim.api.nvim_set_hl(0, "@type", { fg = fg })
	vim.api.nvim_set_hl(0, "@type.definition", { fg = fg })

	-- Treesitter - Properties/Fields (quiet style)
	vim.api.nvim_set_hl(0, "@property", { fg = fg })
	vim.api.nvim_set_hl(0, "@field", { fg = fg })
	vim.api.nvim_set_hl(0, "@variable.member", { fg = fg })

	-- Note: LSP semantic token highlights (@lsp.type.*) are now configured
	-- in plugin/nvim-lsp.lua to ensure they're applied when LSP attaches

	-- Completion menu (nvim-cmp)
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fg })
	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fg })
	vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fg })
	vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fg })
	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fg })
	vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fg })
	vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fg })

	-- Breadcrumbs (nvim-navic)
	vim.api.nvim_set_hl(0, "NavicIconsClass", { fg = fg })
	vim.api.nvim_set_hl(0, "NavicIconsMethod", { fg = fg })
	vim.api.nvim_set_hl(0, "NavicIconsFunction", { fg = fg })

	-- Punctuation: brackets, parentheses, delimiters (quiet/muted)
	vim.api.nvim_set_hl(0, "Delimiter", { fg = fg_muted })
	vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = fg_muted })
	vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = fg_muted })
	vim.api.nvim_set_hl(0, "@punctuation.special", { fg = fg_muted })

	-- Legacy treesitter groups
	vim.api.nvim_set_hl(0, "TSPunctBracket", { fg = fg_muted })
	vim.api.nvim_set_hl(0, "TSPunctDelimiter", { fg = fg_muted })

	-- Rust-specific punctuation groups (from rust.vim syntax)
	vim.api.nvim_set_hl(0, "rustOperator", { fg = fg_muted })
	vim.api.nvim_set_hl(0, "rustPubScopeDelim", { fg = fg_muted })
	vim.api.nvim_set_hl(0, "rustModPathSep", { fg = fg_muted })
	vim.api.nvim_set_hl(0, "rustArrowCharacter", { fg = fg_muted })

	-- Matching parenthesis/bracket highlighting
	-- Note: Keep MatchParen distinct with underline for visibility
	vim.api.nvim_set_hl(0, "MatchParen", { fg = fg, underline = true })

	-- Disable LSP semantic token highlighting to allow Treesitter custom highlights
	vim.api.nvim_set_hl(0, '@lsp.type.operator', {})
	vim.api.nvim_set_hl(0, '@lsp.type.function', {})
	vim.api.nvim_set_hl(0, '@lsp.type.method', {})
	vim.api.nvim_set_hl(0, '@lsp.type.type', {})
	vim.api.nvim_set_hl(0, '@lsp.type.class', {})
	vim.api.nvim_set_hl(0, '@lsp.type.enum', {})
	vim.api.nvim_set_hl(0, '@lsp.type.interface', {})
	vim.api.nvim_set_hl(0, '@lsp.type.struct', {})
	vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', {})


	-- Light theme: CursorLineNr
	if bg == "light" then
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#24292e", bold = true })
	end
end

-- Apply overrides when colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "rustdoc",
	callback = apply_rustdoc_overrides,
})

-- Load colorscheme (autocommand will apply overrides automatically)
vim.cmd.colorscheme("rustdoc")
