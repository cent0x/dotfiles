-- ~/.config/nvim/init.lua

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Disable mouse
vim.opt.mouse = ""
local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  {
    "nvim-telescope/telescope.nvim",
    requires = { {'nvim-lua/plenary.nvim'} }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  }
}

local opts = {
}

-- Setup lazy.nvim
require("lazy").setup(plugins, opts)

-- Setup Catppuccin theme
require("catppuccin").setup({
  transparent_background = true,
  term_colors = true,
  styles = {
    comments = { "italic" },
    keywords = { "bold" },
    functions = { "italic", "bold" },
    },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
  },
})
vim.cmd.colorscheme("catppuccin")

-- Setup Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Setup nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "python" }, -- List of languages you want to install
  sync_install = false, -- Install languages synchronously (only applied to `ensure_installed`)
  highlight = { enable = true }, -- false will disable the whole extension
  indent = { enable = true },
}
