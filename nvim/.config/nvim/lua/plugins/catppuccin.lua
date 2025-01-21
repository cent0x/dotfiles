return  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
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
        neotree = true,
        telescope = true,
      },
    })
    
    vim.cmd.colorscheme("catppuccin")
    end
}
