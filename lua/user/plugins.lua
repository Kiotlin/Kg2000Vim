local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
  -- My plugins:
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim" -- Dependency which implements some useful window management
  use "nvim-lua/popup.nvim"   -- An implementation of the Popup API from vim in Neovim

  -- colorscheme
  -- use "shaunsingh/nord.nvim" -- Neovim theme based off of the Nord Color Palette
  use "marko-cerovac/material.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp"    -- The completion plugin
  use "hrsh7th/cmp-buffer"  -- Buffer completions
  use "hrsh7th/cmp-path"    -- Path completions
  use "hrsh7th/cmp-cmdline" -- Cmdline completions
  -- cmp snippet engine
  use "L3MON4D3/LuaSnip"
  -- use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lua" -- nvim-cmp source for neovim lua api
  use "rafamadriz/friendly-snippets"
  use "onsails/lspkind.nvim"

  -- lsp
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "hrsh7th/cmp-nvim-lsp"
  use 'folke/trouble.nvim'
  use "jose-elias-alvarez/null-ls.nvim"
  use "MunifTanjim/prettier.nvim"

  -- telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- file explorer
  use "nvim-tree/nvim-tree.lua"
  use "nvim-tree/nvim-web-devicons"

  -- sessions
  use "rmagatti/auto-session"
  use "rmagatti/session-lens"

  -- surround: Add/change/delete surrouding delimiter pairs
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  -- whichkey
  use "folke/which-key.nvim"

  -- dashboard
  use "goolord/alpha-nvim"

  -- status line
  use "nvim-lualine/lualine.nvim"
  -- buffer line
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"

  -- git support
  use "lewis6991/gitsigns.nvim"

  -- impatient
  use "lewis6991/impatient.nvim"

  ---------------- utility plugins ----------------
  -- comment
  use "numToStr/Comment.nvim"
  -- autosave
  -- use "Kiotlin/auto-save.nvim"
  -- autopairs
  use "windwp/nvim-autopairs"
  -- lastplace: save your cursor position
  use "ethanholz/nvim-lastplace"

  -- Move & Motion
  use "phaazon/hop.nvim"

  -- Toggle Terminal
  use "akinsho/toggleterm.nvim"
  -- Toggle Ranger
  use "kevinhwang91/rnvimr"

  ---------------- language support ----------------
  -- Latex
  use "lervag/vimtex"
  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Automatically set up configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
