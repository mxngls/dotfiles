-- Colorscheme configuration
--
-- This file handles:
--   1. macOS appearance sync (dark/light mode detection)
--   2. colorscheme setup

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

-- Create command to manually sync with OS appearance
vim.api.nvim_create_user_command("SyncAppearance", sync_os_appearance, {
	desc = "Sync Neovim appearance with macOS system theme"
})

-- Automatically sync when Neovim gains focus
vim.api.nvim_create_autocmd("FocusGained", {
	callback = sync_os_appearance,
	desc = "Auto-sync appearance with macOS when gaining focus"
})

-- Load colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme("default")
