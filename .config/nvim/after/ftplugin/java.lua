-- shared
local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])

-- jdtls
require("jdtls").start_or_attach({
	cmd = {
		vim.fn.system("/usr/libexec/java_home -v 21"):gsub("\n", "") .. "/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens=java.base/java.util=ALL-UNNAMED",
		"--add-opens=java.base/java.lang=ALL-UNNAMED",
		("-javaagent:%s"):format(vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar")),
		"-jar",
		vim.fn.glob(
			vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
		),
		"-configuration",
		vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/config_mac"),
		"-data",
		vim.fn.expand("~/.cache/jdtls/workspace") .. root_dir,
	},
	root_dir = root_dir,
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-21",
						path = vim.fn.system("/usr/libexec/java_home -v 21"):gsub("\n", ""),
						default = true,
					},
				},
			},
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
