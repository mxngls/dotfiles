-- Rustdoc colorscheme for Neovim
-- Based on the Rust documentation CSS theme and arborium syntax highlighting
-- Supports both light and dark variants via `vim.o.background`
--
-- Sources:
--   - https://github.com/rust-lang/rust/blob/master/src/librustdoc/html/static/css/rustdoc.css
--   - https://cdn.jsdelivr.net/npm/@arborium/arborium/dist/themes/rustdoc-dark.css
--   - https://cdn.jsdelivr.net/npm/@arborium/arborium/dist/themes/rustdoc-light.css
--
-- Based on official rustdoc CSS color scheme
-- Custom overrides can be applied via ColorScheme autocommand (see init.lua)

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "rustdoc"

local theme
if vim.o.background == "dark" then
	-- Terminal colors (dark)
	vim.g.terminal_color_0 = "#2a2a2a"
	vim.g.terminal_color_1 = "#ee6868"
	vim.g.terminal_color_2 = "#83a300"
	vim.g.terminal_color_3 = "#d97f26"
	vim.g.terminal_color_4 = "#769acb"
	vim.g.terminal_color_5 = "#ab8ac1"
	vim.g.terminal_color_6 = "#3e999f"
	vim.g.terminal_color_7 = "#dddddd"
	vim.g.terminal_color_8 = "#505050"
	vim.g.terminal_color_9 = "#ee6868"
	vim.g.terminal_color_10 = "#83a300"
	vim.g.terminal_color_11 = "#d2991d"
	vim.g.terminal_color_12 = "#3b91e2"
	vim.g.terminal_color_13 = "#b78cf2"
	vim.g.terminal_color_14 = "#2dbfb8"
	vim.g.terminal_color_15 = "#dddddd"

	-- Dark theme colors (from rustdoc CSS)
	local bg = "#2A2A2A"
	local fg = "#dddddd"
	local fg_muted = "#b0b0b0"
	local bg_alt = "#353535"
	local bg_visual = "#505050"
	local bg_search = "#7a7a20"
	local border = "#999999"
	local comment = "#8d8d8b"
	local doc_comment = "#8ca375"

	-- Syntax colors
	local keyword = "#ab8ac1"
	local keyword2 = "#769acb"
	local lifetime = "#d97f26"
	local number = "#83a300"
	local string = "#83a300"
	local literal = "#ee6868"
	local attribute = "#ee6868"
	local self_kw = "#ee6868"
	local macro = "#3e999f"
	local question = "#ff9011"

	-- Semantic colors
	local type_color = "#2dbfb8"
	local trait = "#b78cf2"
	local func = "#2bab63"
	local link = "#d2991d"
	local sidebar_link = "#fdbf35"

	-- UI colors
	local error = "#ff5555"
	local warning = "#ff8e00"
	local info = "#769acb"
	local hint = "#83a300"
	local line_nr = "#3b91e2"

	-- Diff colors
	local diff_add_bg = "#314559"
	local diff_change_bg = "#494a3d"
	local diff_delete_bg = "#59313e"

	theme = {
		-- Editor UI
		Normal = { fg = fg, bg = bg },
		NormalFloat = { fg = fg, bg = bg_alt },
		FloatBorder = { fg = border, bg = bg_alt },
		FloatTitle = { fg = fg, bold = true },
		Cursor = { fg = bg, bg = fg },
		CursorLine = { bg = bg_alt },
		CursorColumn = { bg = bg_alt },
		ColorColumn = { bg = bg_alt },
		LineNr = { fg = comment },
		CursorLineNr = { fg = "#ffffff", bold = true },
		SignColumn = { bg = bg },
		VertSplit = { fg = border },
		WinSeparator = { fg = border },
		Folded = { fg = comment, bg = bg_alt },
		FoldColumn = { fg = comment, bg = bg },
		NonText = { fg = comment },
		SpecialKey = { fg = comment },
		Conceal = { fg = comment },
		EndOfBuffer = { fg = bg },
		Directory = { fg = link },

		-- Search & Selection
		Visual = { bg = bg_visual },
		VisualNOS = { bg = bg_visual },
		Search = { fg = fg, bg = bg_search },
		IncSearch = { fg = bg, bg = link },
		CurSearch = { fg = bg, bg = link },
		Substitute = { fg = bg, bg = literal },

		-- Popup menu
		Pmenu = { fg = fg, bg = bg_alt },
		PmenuSel = { bg = bg_visual, bold = true },
		PmenuSbar = { bg = bg_alt },
		PmenuThumb = { bg = comment },
		PmenuMatch = { fg = warning, bold = true },

		-- Statusline & Tabline
		StatusLine = { fg = fg, bg = bg_alt },
		StatusLineNC = { fg = comment, bg = bg_alt },
		TabLine = { fg = fg, bg = bg_alt },
		TabLineFill = { bg = bg_alt },
		TabLineSel = { fg = fg, bg = bg, bold = true },
		WinBar = { fg = fg, bg = bg, bold = true },
		WinBarNC = { fg = comment, bg = bg },

		-- Messages
		ModeMsg = { fg = fg, bold = true },
		MsgArea = { fg = fg },
		MoreMsg = { fg = string },
		Question = { fg = string },
		ErrorMsg = { fg = error, bold = true },
		WarningMsg = { fg = warning, bold = true },

		-- Diagnostics
		DiagnosticError = { fg = error },
		DiagnosticWarn = { fg = warning },
		DiagnosticInfo = { fg = info },
		DiagnosticHint = { fg = hint },
		DiagnosticUnderlineError = { undercurl = true, sp = error },
		DiagnosticUnderlineWarn = { undercurl = true, sp = warning },
		DiagnosticUnderlineInfo = { undercurl = true, sp = info },
		DiagnosticUnderlineHint = { undercurl = true, sp = hint },
		DiagnosticVirtualTextError = { fg = error, bg = "#3f1515" },
		DiagnosticVirtualTextWarn = { fg = warning, bg = "#3f2f15" },
		DiagnosticVirtualTextInfo = { fg = info, bg = "#1f2f3f" },
		DiagnosticVirtualTextHint = { fg = hint, bg = "#2f3f1f" },

		-- Diffs
		DiffAdd = { bg = diff_add_bg },
		DiffChange = { bg = diff_change_bg },
		DiffDelete = { bg = diff_delete_bg },
		DiffText = { bg = "#5b3b01" },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },

		-- Spell
		SpellBad = { undercurl = true, sp = error },
		SpellCap = { undercurl = true, sp = warning },
		SpellRare = { undercurl = true, sp = info },
		SpellLocal = { undercurl = true, sp = hint },

		-- Syntax highlighting
		Comment = { fg = comment, italic = true },
		Constant = { fg = literal },
		String = { fg = string },
		Character = { fg = string },
		Number = { fg = number },
		Boolean = { fg = literal },
		Float = { fg = number },

		Identifier = { fg = fg },
		Function = { fg = func },

		Statement = { fg = keyword },
		Conditional = { fg = keyword },
		Repeat = { fg = keyword },
		Label = { fg = keyword },
		Operator = { fg = fg_muted },
		Keyword = { fg = keyword },
		Exception = { fg = keyword },

		PreProc = { fg = attribute },
		Include = { fg = keyword },
		Define = { fg = attribute },
		Macro = { fg = macro },
		PreCondit = { fg = attribute },

		Type = { fg = type_color },
		StorageClass = { fg = keyword2 },
		Structure = { fg = fg },
		Typedef = { fg = fg },

		Special = { fg = lifetime },
		SpecialChar = { fg = literal },
		Tag = { fg = link },
		Delimiter = { fg = fg_muted },
		SpecialComment = { fg = doc_comment, italic = true },
		Debug = { fg = warning },

		Underlined = { fg = link, underline = true },
		Ignore = { fg = comment },
		Error = { fg = error },
		Todo = { fg = bg, bg = warning, bold = true },

		Added = { link = "DiffAdd" },
		Changed = { link = "DiffChange" },
		Removed = { link = "DiffDelete" },

		MatchParen = { underline = true, sp = link },
		Title = { fg = keyword, bold = true },

		-- Treesitter
		["@variable"] = { fg = fg },
		["@variable.builtin"] = { fg = self_kw },
		["@variable.parameter"] = { fg = fg },
		["@variable.member"] = { fg = fg },
		["@constant"] = { fg = literal },
		["@constant.builtin"] = { fg = self_kw },
		["@constant.macro"] = { fg = macro },
		["@module"] = { fg = fg },
		["@label"] = { fg = lifetime },
		["@string"] = { fg = string },
		["@string.documentation"] = { fg = doc_comment },
		["@string.regexp"] = { fg = question },
		["@string.escape"] = { fg = literal },
		["@string.special"] = { fg = literal },
		["@string.special.symbol"] = { fg = lifetime },
		["@character"] = { fg = string },
		["@character.special"] = { fg = literal },
		["@boolean"] = { fg = literal },
		["@number"] = { fg = number },
		["@number.float"] = { fg = number },
		["@type"] = { fg = type_color },
		["@type.builtin"] = { fg = keyword2 },
		["@type.definition"] = { fg = type_color },
		["@type.qualifier"] = { fg = keyword2 },
		["@attribute"] = { fg = attribute },
		["@property"] = { fg = fg },
		["@function"] = { fg = func },
		["@function.builtin"] = { fg = func },
		["@function.call"] = { fg = func },
		["@function.macro"] = { fg = macro },
		["@function.method"] = { fg = func },
		["@function.method.call"] = { fg = func },
		["@constructor"] = { fg = func },
		["@operator"] = { fg = fg_muted },
		["@keyword"] = { fg = keyword },
		["@keyword.coroutine"] = { fg = keyword },
		["@keyword.function"] = { fg = keyword },
		["@keyword.operator"] = { fg = keyword },
		["@keyword.import"] = { fg = keyword },
		["@keyword.storage"] = { fg = keyword },
		["@keyword.repeat"] = { fg = keyword },
		["@keyword.return"] = { fg = keyword },
		["@keyword.exception"] = { fg = keyword },
		["@keyword.conditional"] = { fg = keyword },
		["@punctuation.delimiter"] = { fg = fg_muted },
		["@punctuation.bracket"] = { fg = fg_muted },
		["@punctuation.special"] = { fg = lifetime },
		["@comment"] = { fg = comment, italic = true },
		["@comment.documentation"] = { fg = doc_comment, italic = true },
		["@comment.error"] = { fg = error },
		["@comment.warning"] = { fg = warning },
		["@comment.todo"] = { fg = bg, bg = warning },
		["@comment.note"] = { fg = info },
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.heading"] = { fg = keyword, bold = true },
		["@markup.quote"] = { fg = comment, italic = true },
		["@markup.math"] = { fg = number },
		["@markup.link"] = { fg = link },
		["@markup.link.label"] = { fg = link },
		["@markup.link.url"] = { fg = link, underline = true },
		["@markup.raw"] = { fg = string },
		["@markup.list"] = { fg = fg },
		["@diff.plus"] = { link = "DiffAdd" },
		["@diff.minus"] = { link = "DiffDelete" },
		["@diff.delta"] = { link = "DiffChange" },
		["@tag"] = { fg = keyword },
		["@tag.attribute"] = { fg = attribute },
		["@tag.delimiter"] = { fg = fg },

		-- Rust-specific
		-- NOTE: operators use fg for "quiet" style (can't distinguish & and * from other operators)
		["@operator.rust"] = { fg = fg },
		-- Highlight & reference operator differently (custom treesitter query)
		["@operator.reference"] = { fg = keyword2 }, -- blue, like type qualifiers
		-- Highlight * dereference operator differently (custom treesitter query)
		["@operator.dereference"] = { fg = keyword2 }, -- blue, like type qualifiers
		["@storageclass.lifetime.rust"] = { fg = lifetime },
		["@lsp.type.lifetime.rust"] = { fg = lifetime },
		["@keyword.modifier"] = { fg = keyword2 },
		["@lsp.type.keyword.rust"] = { fg = keyword },
		["@lsp.typemod.keyword.controlFlow.rust"] = { fg = keyword },

		-- Rust constants: use fg for "quiet" style (not red)
		["@constant.rust"] = { fg = fg },
		["@lsp.type.const.rust"] = { fg = fg },
		["@lsp.mod.constant.rust"] = {},
		["@lsp.mod.library.rust"] = {},
		["@lsp.typemod.const.constant.rust"] = { fg = fg },
		["@lsp.typemod.const.library.rust"] = { fg = fg },

		-- Rust self/Ok/None/Some/Err: use fg for "quiet" style (not red)
		["@variable.builtin.rust"] = { fg = fg },
		["@lsp.type.selfKeyword.rust"] = { fg = fg },
		["@lsp.typemod.selfKeyword.reference.rust"] = { fg = fg },

		-- Rust prelude types (Result, Option) - blue
		["@lsp.type.builtinType.rust"] = { fg = keyword2 },
		-- Rust prelude values (Ok, Some, None, Err) - red for visibility
		["@lsp.typemod.enumMember.defaultLibrary.rust"] = { fg = self_kw },

		-- Rust ? operator (try operator) - orange
		["@lsp.typemod.operator.controlFlow.rust"] = { fg = lifetime },

		-- Rust attributes: make everything inside #[...] red
		["@lsp.type.attributeBracket.rust"] = { fg = attribute },
		["@lsp.type.builtinAttribute.rust"] = { fg = attribute },
		["@lsp.type.derive.rust"] = { fg = attribute },
		["@lsp.type.deriveHelper.rust"] = { fg = attribute },
		["@lsp.typemod.builtinAttribute.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.function.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.variable.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.property.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.enumMember.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.type.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.struct.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.enum.attribute.rust"] = { fg = attribute },
		["@lsp.typemod.typeAlias.attribute.rust"] = { fg = attribute },

		-- LSP semantic tokens
		["@lsp.type.namespace"] = { fg = fg },
		["@lsp.type.type"] = { fg = type_color },
		["@lsp.type.class"] = { fg = type_color },
		["@lsp.type.enum"] = { fg = type_color },
		["@lsp.type.interface"] = { fg = type_color },
		["@lsp.type.struct"] = { fg = type_color },
		["@lsp.type.typeParameter"] = { fg = type_color },
		["@lsp.type.parameter"] = { fg = fg },
		["@lsp.type.variable"] = { fg = fg },
		["@lsp.type.property"] = { fg = fg },
		["@lsp.type.enumMember"] = { fg = literal },
		["@lsp.type.function"] = { fg = func },
		["@lsp.type.method"] = { fg = func },
		["@lsp.type.macro"] = { fg = macro },
		["@lsp.type.keyword"] = { fg = keyword },
		["@lsp.type.comment"] = { fg = comment },
		["@lsp.type.string"] = { fg = string },
		["@lsp.type.number"] = { fg = number },
		-- NOTE: Disabled LSP operator highlighting to allow treesitter custom operator highlights
		-- ["@lsp.type.operator"] = { fg = fg_muted },
		["@lsp.type.decorator"] = { fg = attribute },
		["@lsp.type.selfKeyword"] = { fg = self_kw },
		["@lsp.mod.documentation"] = { fg = doc_comment },

		-- Gitsigns
		GitSignsAdd = { fg = string },
		GitSignsChange = { fg = link },
		GitSignsDelete = { fg = error },

		-- Telescope
		TelescopeBorder = { fg = border },
		TelescopePromptBorder = { fg = border },
		TelescopeResultsBorder = { fg = border },
		TelescopePreviewBorder = { fg = border },
		TelescopeMatching = { fg = warning, bold = true },
		TelescopeSelection = { bg = bg_visual, bold = true },
		TelescopePromptPrefix = { fg = link, bold = true },
		TelescopeTitle = { fg = sidebar_link, bold = true },

		-- NvimTree / Neo-tree
		NvimTreeNormal = { fg = fg, bg = bg_alt },
		NvimTreeFolderIcon = { fg = link },
		NvimTreeFolderName = { fg = link },
		NvimTreeOpenedFolderName = { fg = link },
		NvimTreeRootFolder = { fg = keyword },
		NvimTreeGitDirty = { fg = warning },
		NvimTreeGitNew = { fg = string },
		NeoTreeNormal = { fg = fg, bg = bg_alt },
		NeoTreeDirectoryIcon = { fg = link },
		NeoTreeDirectoryName = { fg = link },
		NeoTreeRootName = { fg = keyword, bold = true },

		-- Which-key
		WhichKey = { fg = keyword },
		WhichKeyGroup = { fg = link },
		WhichKeyDesc = { fg = fg },
		WhichKeySeparator = { fg = comment },
		WhichKeyFloat = { bg = bg_alt },

		-- Indent-blankline
		IblIndent = { fg = border },
		IblScope = { fg = comment },

		-- Lazy
		LazyNormal = { fg = fg, bg = bg_alt },
		LazyButton = { fg = fg, bg = bg_visual },
		LazyButtonActive = { fg = bg, bg = link },

		-- Mason
		MasonNormal = { fg = fg, bg = bg_alt },

		-- Notify
		NotifyERRORBorder = { fg = error },
		NotifyWARNBorder = { fg = warning },
		NotifyINFOBorder = { fg = info },
		NotifyDEBUGBorder = { fg = comment },
		NotifyTRACEBorder = { fg = hint },
		NotifyERRORIcon = { fg = error },
		NotifyWARNIcon = { fg = warning },
		NotifyINFOIcon = { fg = info },
		NotifyDEBUGIcon = { fg = comment },
		NotifyTRACEIcon = { fg = hint },
		NotifyERRORTitle = { fg = error },
		NotifyWARNTitle = { fg = warning },
		NotifyINFOTitle = { fg = info },
		NotifyDEBUGTitle = { fg = comment },
		NotifyTRACETitle = { fg = hint },

		-- Cmp
		CmpItemAbbr = { fg = fg },
		CmpItemAbbrDeprecated = { fg = comment, strikethrough = true },
		CmpItemAbbrMatch = { fg = warning, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = warning, bold = true },
		CmpItemMenu = { fg = comment },
		CmpItemKindDefault = { fg = fg },
		CmpItemKindKeyword = { fg = keyword },
		CmpItemKindVariable = { fg = fg },
		CmpItemKindConstant = { fg = literal },
		CmpItemKindFunction = { fg = func },
		CmpItemKindMethod = { fg = func },
		CmpItemKindConstructor = { fg = func },
		CmpItemKindClass = { fg = type_color },
		CmpItemKindInterface = { fg = type_color },
		CmpItemKindStruct = { fg = type_color },
		CmpItemKindEnum = { fg = type_color },
		CmpItemKindModule = { fg = link },
		CmpItemKindProperty = { fg = fg },
		CmpItemKindField = { fg = fg },
		CmpItemKindTypeParameter = { fg = fg },
		CmpItemKindEnumMember = { fg = literal },
		CmpItemKindSnippet = { fg = macro },
		CmpItemKindText = { fg = string },
		CmpItemKindFile = { fg = link },
		CmpItemKindFolder = { fg = link },

		-- LSP references
		LspReferenceText = { bg = bg_visual },
		LspReferenceRead = { bg = bg_visual },
		LspReferenceWrite = { bg = bg_visual, underline = true, sp = link },

		-- Illuminate
		IlluminatedWordText = { bg = bg_visual },
		IlluminatedWordRead = { bg = bg_visual },
		IlluminatedWordWrite = { bg = bg_visual },

		-- Navic (breadcrumbs)
		NavicText = { fg = fg },
		NavicSeparator = { fg = comment },
		NavicIconsFile = { fg = link },
		NavicIconsModule = { fg = link },
		NavicIconsClass = { fg = type_color },
		NavicIconsMethod = { fg = func },
		NavicIconsFunction = { fg = func },
		NavicIconsConstant = { fg = literal },
		NavicIconsString = { fg = string },
		NavicIconsNumber = { fg = number },
		NavicIconsStruct = { fg = fg },
	}
else
	-- Terminal colors (light)
	vim.g.terminal_color_0 = "#f5f5f5"
	vim.g.terminal_color_1 = "#c82829"
	vim.g.terminal_color_2 = "#718c00"
	vim.g.terminal_color_3 = "#b76514"
	vim.g.terminal_color_4 = "#4271ae"
	vim.g.terminal_color_5 = "#8959a8"
	vim.g.terminal_color_6 = "#3e999f"
	vim.g.terminal_color_7 = "#000000"
	vim.g.terminal_color_8 = "#8e908c"
	vim.g.terminal_color_9 = "#c82829"
	vim.g.terminal_color_10 = "#718c00"
	vim.g.terminal_color_11 = "#ad7c37"
	vim.g.terminal_color_12 = "#3873ad"
	vim.g.terminal_color_13 = "#6e4fc9"
	vim.g.terminal_color_14 = "#ad378a"
	vim.g.terminal_color_15 = "#000000"

	-- Light theme colors (based on rustdoc CSS)
	-- NOTE: Using code block background (#f5f5f5) instead of white for editor
	local bg = "#f5f5f5"
	local fg = "#000000"
	local fg_muted = "#505050"
	local bg_alt = "#e8e8e8"
	local bg_visual = "#d8d8d8"
	local bg_search = "#d8d898"
	local border = "#a0a0a0"
	local comment = "#8e908c"
	local doc_comment = "#4d4d4c"

	-- Syntax colors
	local keyword = "#8959a8"
	local keyword2 = "#4271ae"
	local lifetime = "#b76514"
	local number = "#718c00"
	local string = "#718c00"
	local literal = "#c82829"
	local attribute = "#c82829"
	local self_kw = "#c82829"
	local macro = "#3e999f"
	local question = "#ff9011"

	-- Semantic colors
	local type_color = "#ad378a"
	local trait = "#6e4fc9"
	local func = "#ad7c37"
	local link = "#3873ad"
	local sidebar_link = "#356da4"

	-- UI colors
	local error = "#c82829"
	local warning = "#ff8e00"
	local info = "#4271ae"
	local hint = "#718c00"
	local line_nr = "#c67e2d"

	-- Diff colors
	local diff_add_bg = "#b0c890"
	local diff_change_bg = "#c8c890"
	local diff_delete_bg = "#d0a098"

	-- Optional background colors for syntax elements (inspired by tonsky.me/blog/syntax-highlighting)
	-- Enable with: vim.g.rustdoc_light_use_backgrounds = true
	local use_backgrounds = vim.g.rustdoc_light_use_backgrounds == true
	local bg_keyword = use_backgrounds and "#f3eafc" or nil -- purple tint
	local bg_keyword2 = use_backgrounds and "#eaf3ff" or nil -- blue tint
	local bg_lifetime = use_backgrounds and "#fff5ed" or nil -- orange tint
	local bg_number = use_backgrounds and "#edf8e8" or nil -- green tint
	local bg_string = use_backgrounds and "#edf8e8" or nil -- green tint
	local bg_literal = use_backgrounds and "#fff0f0" or nil -- red/pink tint
	local bg_macro = use_backgrounds and "#e8fcfc" or nil -- cyan tint

	theme = {
		-- Editor UI
		Normal = { fg = fg, bg = bg },
		NormalFloat = { fg = fg, bg = bg_alt },
		FloatBorder = { fg = border, bg = bg_alt },
		FloatTitle = { fg = fg, bold = true },
		Cursor = { fg = bg, bg = fg },
		CursorLine = { bg = bg_alt },
		CursorColumn = { bg = bg_alt },
		ColorColumn = { bg = bg_alt },
		LineNr = { fg = comment },
		CursorLineNr = { fg = "#000000", bold = true },
		SignColumn = { bg = bg },
		VertSplit = { fg = border },
		WinSeparator = { fg = border },
		Folded = { fg = comment, bg = bg_alt },
		FoldColumn = { fg = comment, bg = bg },
		NonText = { fg = comment },
		SpecialKey = { fg = comment },
		Conceal = { fg = comment },
		EndOfBuffer = { fg = bg },
		Directory = { fg = link },

		-- Search & Selection
		Visual = { bg = bg_visual },
		VisualNOS = { bg = bg_visual },
		Search = { fg = fg, bg = bg_search },
		IncSearch = { fg = bg, bg = link },
		CurSearch = { fg = bg, bg = link },
		Substitute = { fg = bg, bg = literal },

		-- Popup menu
		Pmenu = { fg = fg, bg = bg_alt },
		PmenuSel = { bg = bg_visual, bold = true },
		PmenuSbar = { bg = bg_alt },
		PmenuThumb = { bg = comment },
		PmenuMatch = { fg = func, bold = true },

		-- Statusline & Tabline
		StatusLine = { fg = fg, bg = bg_alt },
		StatusLineNC = { fg = comment, bg = bg_alt },
		TabLine = { fg = fg, bg = bg_alt },
		TabLineFill = { bg = bg_alt },
		TabLineSel = { fg = fg, bg = bg, bold = true },
		WinBar = { fg = fg, bg = bg, bold = true },
		WinBarNC = { fg = comment, bg = bg },

		-- Messages
		ModeMsg = { fg = fg, bold = true },
		MsgArea = { fg = fg },
		MoreMsg = { fg = string },
		Question = { fg = string },
		ErrorMsg = { fg = error, bold = true },
		WarningMsg = { fg = warning, bold = true },

		-- Diagnostics
		DiagnosticError = { fg = error },
		DiagnosticWarn = { fg = warning },
		DiagnosticInfo = { fg = info },
		DiagnosticHint = { fg = hint },
		DiagnosticUnderlineError = { undercurl = true, sp = error },
		DiagnosticUnderlineWarn = { undercurl = true, sp = warning },
		DiagnosticUnderlineInfo = { undercurl = true, sp = info },
		DiagnosticUnderlineHint = { undercurl = true, sp = hint },
		DiagnosticVirtualTextError = { fg = error, bg = "#c8b0b0" },
		DiagnosticVirtualTextWarn = { fg = warning, bg = "#c8c0a8" },
		DiagnosticVirtualTextInfo = { fg = info, bg = "#b0b8c8" },
		DiagnosticVirtualTextHint = { fg = hint, bg = "#b8c8b8" },

		-- Diffs
		DiffAdd = { bg = diff_add_bg },
		DiffChange = { bg = diff_change_bg },
		DiffDelete = { bg = diff_delete_bg },
		DiffText = { bg = "#b8b070" },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },

		-- Spell
		SpellBad = { undercurl = true, sp = error },
		SpellCap = { undercurl = true, sp = warning },
		SpellRare = { undercurl = true, sp = info },
		SpellLocal = { undercurl = true, sp = hint },

		-- Syntax highlighting
		Comment = { fg = comment, italic = true },
		Constant = { fg = literal, bg = bg_literal },
		String = { fg = string, bg = bg_string },
		Character = { fg = string, bg = bg_string },
		Number = { fg = number, bg = bg_number },
		Boolean = { fg = literal, bg = bg_literal },
		Float = { fg = number, bg = bg_number },

		Identifier = { fg = fg },
		Function = { fg = func },

		Statement = { fg = keyword, bg = bg_keyword },
		Conditional = { fg = keyword, bg = bg_keyword },
		Repeat = { fg = keyword, bg = bg_keyword },
		Label = { fg = keyword, bg = bg_keyword },
		Operator = { fg = fg_muted },
		Keyword = { fg = keyword, bg = bg_keyword },
		Exception = { fg = keyword, bg = bg_keyword },

		PreProc = { fg = attribute, bg = bg_literal },
		Include = { fg = keyword, bg = bg_keyword },
		Define = { fg = attribute, bg = bg_literal },
		Macro = { fg = macro, bg = bg_macro },
		PreCondit = { fg = attribute, bg = bg_literal },

		Type = { fg = type_color },
		StorageClass = { fg = keyword2, bg = bg_keyword },
		Structure = { fg = fg },
		Typedef = { fg = fg },

		Special = { fg = lifetime, bg = bg_lifetime },
		SpecialChar = { fg = literal, bg = bg_literal },
		Tag = { fg = link },
		Delimiter = { fg = fg_muted },
		SpecialComment = { fg = doc_comment, italic = true },
		Debug = { fg = warning },

		Underlined = { fg = link, underline = true },
		Ignore = { fg = comment },
		Error = { fg = error },
		Todo = { fg = bg, bg = warning, bold = true },

		Added = { link = "DiffAdd" },
		Changed = { link = "DiffChange" },
		Removed = { link = "DiffDelete" },

		MatchParen = { underline = true, sp = link },
		Title = { fg = keyword, bold = true },

		-- Treesitter
		["@variable"] = { fg = fg },
		["@variable.builtin"] = { fg = self_kw, bg = bg_literal },
		["@variable.parameter"] = { fg = fg },
		["@variable.member"] = { fg = fg },
		["@constant"] = { fg = literal, bg = bg_literal },
		["@constant.builtin"] = { fg = self_kw, bg = bg_literal },
		["@constant.macro"] = { fg = macro, bg = bg_macro },
		["@module"] = { fg = fg },
		["@label"] = { fg = lifetime, bg = bg_lifetime },
		["@string"] = { fg = string, bg = bg_string },
		["@string.documentation"] = { fg = doc_comment },
		["@string.regexp"] = { fg = question },
		["@string.escape"] = { fg = literal, bg = bg_literal },
		["@string.special"] = { fg = literal, bg = bg_literal },
		["@string.special.symbol"] = { fg = lifetime, bg = bg_lifetime },
		["@character"] = { fg = string, bg = bg_string },
		["@character.special"] = { fg = literal, bg = bg_literal },
		["@boolean"] = { fg = literal, bg = bg_literal },
		["@number"] = { fg = number, bg = bg_number },
		["@number.float"] = { fg = number, bg = bg_number },
		["@type"] = { fg = type_color },
		["@type.builtin"] = { fg = keyword2, bg = bg_keyword2 },
		["@type.definition"] = { fg = type_color },
		["@type.qualifier"] = { fg = keyword2, bg = bg_keyword2 },
		["@attribute"] = { fg = attribute, bg = bg_literal },
		["@property"] = { fg = fg },
		["@function"] = { fg = fg },
		["@function.builtin"] = { fg = fg },
		["@function.call"] = { fg = fg },
		["@function.macro"] = { fg = macro, bg = bg_macro },
		["@function.method"] = { fg = fg },
		["@function.method.call"] = { fg = fg },
		["@constructor"] = { fg = fg },
		["@operator"] = { fg = fg_muted },
		["@keyword"] = { fg = keyword, bg = bg_keyword },
		["@keyword.coroutine"] = { fg = keyword, bg = bg_keyword },
		["@keyword.function"] = { fg = keyword, bg = bg_keyword },
		["@keyword.operator"] = { fg = keyword, bg = bg_keyword },
		["@keyword.import"] = { fg = keyword, bg = bg_keyword },
		["@keyword.storage"] = { fg = keyword, bg = bg_keyword },
		["@keyword.repeat"] = { fg = keyword, bg = bg_keyword },
		["@keyword.return"] = { fg = keyword, bg = bg_keyword },
		["@keyword.exception"] = { fg = keyword, bg = bg_keyword },
		["@keyword.conditional"] = { fg = keyword, bg = bg_keyword },
		["@punctuation.delimiter"] = { fg = fg_muted },
		["@punctuation.bracket"] = { fg = fg_muted },
		["@punctuation.special"] = { fg = lifetime, bg = bg_lifetime },
		["@comment"] = { fg = comment, italic = true },
		["@comment.documentation"] = { fg = doc_comment, italic = true },
		["@comment.error"] = { fg = error },
		["@comment.warning"] = { fg = warning },
		["@comment.todo"] = { fg = bg, bg = warning },
		["@comment.note"] = { fg = info },
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.heading"] = { fg = keyword, bg = bg_keyword, bold = true },
		["@markup.quote"] = { fg = comment, italic = true },
		["@markup.math"] = { fg = number, bg = bg_number },
		["@markup.link"] = { fg = link },
		["@markup.link.label"] = { fg = link },
		["@markup.link.url"] = { fg = link, underline = true },
		["@markup.raw"] = { fg = string, bg = bg_string },
		["@markup.list"] = { fg = fg },
		["@diff.plus"] = { link = "DiffAdd" },
		["@diff.minus"] = { link = "DiffDelete" },
		["@diff.delta"] = { link = "DiffChange" },
		["@tag"] = { fg = keyword, bg = bg_keyword },
		["@tag.attribute"] = { fg = attribute, bg = bg_literal },
		["@tag.delimiter"] = { fg = fg },

		-- Rust-specific
		-- NOTE: operators use fg for "quiet" style (can't distinguish & and * from other operators)
		["@operator.rust"] = { fg = fg },
		-- Highlight & reference operator differently (custom treesitter query)
		["@operator.reference"] = { fg = keyword2, bg = bg_keyword2 }, -- blue, like type qualifiers
		-- Highlight * dereference operator differently (custom treesitter query)
		["@operator.dereference"] = { fg = keyword2, bg = bg_keyword2 }, -- blue, like type qualifiers
		["@storageclass.lifetime.rust"] = { fg = lifetime, bg = bg_lifetime },
		["@lsp.type.lifetime.rust"] = { fg = lifetime, bg = bg_lifetime },
		["@keyword.modifier"] = { fg = keyword2, bg = bg_keyword2 },
		["@lsp.type.keyword.rust"] = { fg = keyword, bg = bg_keyword },
		["@lsp.typemod.keyword.controlFlow.rust"] = { fg = keyword, bg = bg_keyword },

		-- Rust constants: use fg for "quiet" style (not red)
		["@constant.rust"] = { fg = fg },
		["@lsp.type.const.rust"] = { fg = fg },
		["@lsp.mod.constant.rust"] = {},
		["@lsp.mod.library.rust"] = {},
		["@lsp.typemod.const.constant.rust"] = { fg = fg },
		["@lsp.typemod.const.library.rust"] = { fg = fg },

		-- Rust self/Ok/None/Some/Err: use fg for "quiet" style (not red)
		["@variable.builtin.rust"] = { fg = fg },
		["@lsp.type.selfKeyword.rust"] = { fg = fg },
		["@lsp.typemod.selfKeyword.reference.rust"] = { fg = fg },

		-- Rust prelude types (Result, Option) - blue
		["@lsp.type.builtinType.rust"] = { fg = keyword2, bg = bg_keyword2 },
		-- Rust prelude values (Ok, Some, None, Err) - red for visibility
		["@lsp.typemod.enumMember.defaultLibrary.rust"] = { fg = self_kw, bg = bg_literal },

		-- Rust ? operator (try operator) - orange
		["@lsp.typemod.operator.controlFlow.rust"] = { fg = lifetime, bg = bg_lifetime },

		-- Rust attributes: make everything inside #[...] red
		["@lsp.type.attributeBracket.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.type.builtinAttribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.type.derive.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.type.deriveHelper.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.builtinAttribute.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.function.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.variable.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.property.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.enumMember.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.type.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.struct.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.enum.attribute.rust"] = { fg = attribute, bg = bg_literal },
		["@lsp.typemod.typeAlias.attribute.rust"] = { fg = attribute, bg = bg_literal },

		-- LSP semantic tokens
		-- NOTE: type/function/method use fg for "quiet" style (arborium uses type_color/func)
		["@lsp.type.namespace"] = { fg = fg },
		["@lsp.type.type"] = { fg = fg },
		["@lsp.type.class"] = { fg = fg },
		["@lsp.type.enum"] = { fg = fg },
		["@lsp.type.interface"] = { fg = fg },
		["@lsp.type.struct"] = { fg = fg },
		["@lsp.type.typeParameter"] = { fg = fg },
		["@lsp.type.parameter"] = { fg = fg },
		["@lsp.type.variable"] = { fg = fg },
		["@lsp.type.property"] = { fg = fg },
		["@lsp.type.enumMember"] = { fg = literal, bg = bg_literal },
		["@lsp.type.function"] = { fg = fg },
		["@lsp.type.method"] = { fg = fg },
		["@lsp.type.macro"] = { fg = macro, bg = bg_macro },
		["@lsp.type.keyword"] = { fg = keyword, bg = bg_keyword },
		["@lsp.type.comment"] = { fg = comment },
		["@lsp.type.string"] = { fg = string, bg = bg_string },
		["@lsp.type.number"] = { fg = number, bg = bg_number },
		-- NOTE: Disabled LSP operator highlighting to allow treesitter custom operator highlights
		-- ["@lsp.type.operator"] = { fg = fg_muted },
		["@lsp.type.decorator"] = { fg = attribute, bg = bg_literal },
		["@lsp.type.selfKeyword"] = { fg = self_kw, bg = bg_literal },
		["@lsp.mod.documentation"] = { fg = doc_comment },

		-- Gitsigns
		GitSignsAdd = { fg = string },
		GitSignsChange = { fg = link },
		GitSignsDelete = { fg = error },

		-- Telescope
		TelescopeBorder = { fg = border },
		TelescopePromptBorder = { fg = border },
		TelescopeResultsBorder = { fg = border },
		TelescopePreviewBorder = { fg = border },
		TelescopeMatching = { fg = func, bold = true },
		TelescopeSelection = { bg = bg_visual, bold = true },
		TelescopePromptPrefix = { fg = link, bold = true },
		TelescopeTitle = { fg = sidebar_link, bold = true },

		-- NvimTree / Neo-tree
		NvimTreeNormal = { fg = fg, bg = bg_alt },
		NvimTreeFolderIcon = { fg = link },
		NvimTreeFolderName = { fg = link },
		NvimTreeOpenedFolderName = { fg = link },
		NvimTreeRootFolder = { fg = keyword },
		NvimTreeGitDirty = { fg = warning },
		NvimTreeGitNew = { fg = string },
		NeoTreeNormal = { fg = fg, bg = bg_alt },
		NeoTreeDirectoryIcon = { fg = link },
		NeoTreeDirectoryName = { fg = link },
		NeoTreeRootName = { fg = keyword, bold = true },

		-- Which-key
		WhichKey = { fg = keyword },
		WhichKeyGroup = { fg = link },
		WhichKeyDesc = { fg = fg },
		WhichKeySeparator = { fg = comment },
		WhichKeyFloat = { bg = bg_alt },

		-- Indent-blankline
		IblIndent = { fg = border },
		IblScope = { fg = comment },

		-- Lazy
		LazyNormal = { fg = fg, bg = bg_alt },
		LazyButton = { fg = fg, bg = bg_visual },
		LazyButtonActive = { fg = bg, bg = link },

		-- Mason
		MasonNormal = { fg = fg, bg = bg_alt },

		-- Notify
		NotifyERRORBorder = { fg = error },
		NotifyWARNBorder = { fg = warning },
		NotifyINFOBorder = { fg = info },
		NotifyDEBUGBorder = { fg = comment },
		NotifyTRACEBorder = { fg = hint },
		NotifyERRORIcon = { fg = error },
		NotifyWARNIcon = { fg = warning },
		NotifyINFOIcon = { fg = info },
		NotifyDEBUGIcon = { fg = comment },
		NotifyTRACEIcon = { fg = hint },
		NotifyERRORTitle = { fg = error },
		NotifyWARNTitle = { fg = warning },
		NotifyINFOTitle = { fg = info },
		NotifyDEBUGTitle = { fg = comment },
		NotifyTRACETitle = { fg = hint },

		-- Cmp
		CmpItemAbbr = { fg = fg },
		CmpItemAbbrDeprecated = { fg = comment, strikethrough = true },
		CmpItemAbbrMatch = { fg = func, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = func, bold = true },
		CmpItemMenu = { fg = comment },
		CmpItemKindDefault = { fg = fg },
		CmpItemKindKeyword = { fg = keyword },
		CmpItemKindVariable = { fg = fg },
		CmpItemKindConstant = { fg = literal },
		CmpItemKindFunction = { fg = func },
		CmpItemKindMethod = { fg = func },
		CmpItemKindConstructor = { fg = func },
		CmpItemKindClass = { fg = type_color },
		CmpItemKindInterface = { fg = type_color },
		CmpItemKindStruct = { fg = type_color },
		CmpItemKindEnum = { fg = type_color },
		CmpItemKindModule = { fg = link },
		CmpItemKindProperty = { fg = fg },
		CmpItemKindField = { fg = fg },
		CmpItemKindTypeParameter = { fg = fg },
		CmpItemKindEnumMember = { fg = literal },
		CmpItemKindSnippet = { fg = macro },
		CmpItemKindText = { fg = string },
		CmpItemKindFile = { fg = link },
		CmpItemKindFolder = { fg = link },

		-- LSP references
		LspReferenceText = { bg = bg_visual },
		LspReferenceRead = { bg = bg_visual },
		LspReferenceWrite = { bg = bg_visual, underline = true, sp = link },

		-- Illuminate
		IlluminatedWordText = { bg = bg_visual },
		IlluminatedWordRead = { bg = bg_visual },
		IlluminatedWordWrite = { bg = bg_visual },

		-- Navic (breadcrumbs)
		NavicText = { fg = fg },
		NavicSeparator = { fg = comment },
		NavicIconsFile = { fg = link },
		NavicIconsModule = { fg = link },
		NavicIconsClass = { fg = type_color },
		NavicIconsMethod = { fg = func },
		NavicIconsFunction = { fg = func },
		NavicIconsConstant = { fg = literal },
		NavicIconsString = { fg = string },
		NavicIconsNumber = { fg = number },
		NavicIconsStruct = { fg = fg },
	}
end

for group, hl in pairs(theme) do
	vim.api.nvim_set_hl(0, group, hl)
end
