local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- { import = "lazyvim.plugins.extras.formatting.prettier" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- import/override with your plugins
    { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

function delayFunctionsInSeries(functions)
  for _, func in ipairs(functions) do
    vim.defer_fn(func, 50 * _)
  end
end

function setup_workspace()
  vim.cmd("lua require('persistence').load()")

  vim.defer_fn(function()
    delayFunctionsInSeries({
      function()
        vim.cmd("Neotree")
      end,

      -- Step 1: Move to the left window (neotree/nvimtree)
      function()
        vim.cmd("wincmd h")
      end,
      -- Step 2: Split horizontally
      function()
        vim.cmd("split")
      end,

      -- Step 3: Spawn "cmatrix -u 6" on terminal in the lower window
      function()
        vim.cmd("term cmatrix -u 6")
      end,

      -- Step 4: Shorten the lower window to 10 character height
      function()
        vim.cmd("resize 10")
      end,

      -- Move to the right window
      function()
        vim.cmd("wincmd l")
      end,

      -- Split right window again
      function()
        vim.cmd("split")
      end,

      -- Resize to 15 character height
      function()
        vim.cmd("resize 15")
      end,

      -- Spawn terminal in the lower window
      function()
        vim.cmd('term zsh -i -c "neofetch; exec zsh"')
      end,

      -- Move back up to the top window
      function()
        vim.cmd("wincmd k")
      end,

      -- Move back up to the top window
      function()
        if true then
          return
        end
        vim.cmd("BufferLineCyclePrev")
        vim.cmd("BufferLineCyclePrev")
      end,
    })
  end, 250)
end

vim.cmd("autocmd VimEnter * lua setup_workspace()")
