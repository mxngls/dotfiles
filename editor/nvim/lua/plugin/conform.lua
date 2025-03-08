require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        c = { "clang-format" }
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
