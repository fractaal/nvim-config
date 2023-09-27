-- vim.g.gruvbox_material_background = "soft"

return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", opts = { contrast = "soft" }  },
  { "Rigellute/shades-of-purple.vim" },
  { "sainnhe/gruvbox-material" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "shades_of_purple",
      colorscheme = "gruvbox",
    },
  },
}
