return {
 
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
    'MunifTanjim/nui.nvim',
    },
  
  config = function()
  require("neo-tree").setup({

  filesystem = {
    filtered_items = {
      visible = true,  -- This makes hidden files visible
      hide_dotfiles = false,  -- This ensures dotfiles are not hidden
      hide_gitignored = true,  -- This hides files ignored by Git
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = "true",
    hijack_netrw_behavior = "open_current",
    },
    window = {
      position = "left",
      width = 35,
      },
  })

  vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', { noremap = true, silent = true })
  end
}

