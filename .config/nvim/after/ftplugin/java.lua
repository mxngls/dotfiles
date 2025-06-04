-- shared
local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])

-- jdtls
require("jdtls").start_or_attach({
	cmd = {
		"/Users/max/.local/share/nvim/mason/bin/jdtls",
		("--jvm-arg=-javaagent:%s"):format(vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar")),
	},
	root_dir = root_dir,
	settings = {
		java = {
			format = {
				enabled = false,
			},
		},
	},
})

-- checkstyle
local checkstyle_config = root_dir and vim.fn.expand(root_dir .. "/config/checkstyle/checkstyle.xml") or nil
require("lint").linters_by_ft = { java = { "checkstyle" } }
require("lint").linters.checkstyle.config_file = checkstyle_config or "/google_checks.xml"

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

-- spaces instead of tabs
vim.bo.expandtab = true
