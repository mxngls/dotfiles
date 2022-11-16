require("nvim-tree").setup({
  sort_by = "case_sensitive",
  open_on_setup = true,
  open_on_setup_file = true,
  actions ={
  open_file = {
      resize_window = true
    }
  },
  view = {
    adaptive_size = true,
    number = true,
    relativenumber = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

