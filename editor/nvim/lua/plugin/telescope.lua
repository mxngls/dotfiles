local telescope = require('telescope')

telescope.setup({
    defaults = {
        file_ignore_patterns = { ".git/" }
    }
})

-- load extensions
telescope.load_extension('fzy_native')
