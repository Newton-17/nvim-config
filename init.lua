vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.health_check = 0
vim.g.mapleader = " "
vim.wo.number = true

vim.filetype.add {
  extension = {
    zsh = "sh",
    sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
  },
  filename = {
    [".zshrc"] = "sh",
    [".zshenv"] = "sh",
  },
}

require "config.lazy"

-- nvim tree
require("nvim-tree").setup {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}

-- Explorer Key Mappigns
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.api.nvim_set_keymap("n", "<leader>ft", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Jump Too
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Jump to definition
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Jump to declaration
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- Jump to implementation
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- List references
vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, opts) -- Jump to type definition

-- Spacing Stuff (Tab = 4 spaces)
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Insert For GO

vim.api.nvim_set_keymap("n", "<leader>ee", "iif err != nil { <cr> log.Fatal(err) <cr> }", {})
