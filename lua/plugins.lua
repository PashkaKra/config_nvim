-- lua/plugins.lua

-- Place where packer is goint to be saved
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Install packer from github if is not in our system
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Show packer messages in a popup. Looks cooler
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Alt installation of packer without a function
packer.reset()
local use = packer.use

--[[
  Start adding plugins here
]]
use({ -- Have packer manage itself  
    "wbthomason/packer.nvim", opt = true
})
use({ -- Port of VSCode's Tokio Night theme
    "folke/tokyonight.nvim",
    config = function()
        vim.g.tokyonight_style = "storm"
-- Possible values: storm, night and day
    end,
})

--    use {'wbthomason/packer.nvim', opt = true}
use {'mhinz/vim-startify'} -- стартовый экран
use {'sainnhe/gruvbox-material' }
use {'neovim/nvim-lspconfig'}
use {'nvim-lua/completion-nvim'}
use {'tjdevries/nlua.nvim'}
use {'tpope/vim-dispatch'}
use {'tpope/vim-fugitive'}
use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
use {'lewis6991/gitsigns.nvim', 
    config = function()
    require('gitsigns').setup()
    end
}
use({ -- Install and configure tree-sitter languages
     "nvim-treesitter/nvim-treesitter",
     run = ":TSUpdate",
     config = function()
    require("config.treesitter")
   -- require('nvim-ts-autotag').setup()
    end,
})
use {
     "romgrk/nvim-treesitter-context",
     requires = { "nvim-treesitter/nvim-treesitter" }, -- nvim-treesitter-context depends on nvim-treesitter
     config = function()
         local ctx = require "treesitter-context"
         ctx.setup {}
    end,
}
use{'ryanoasis/vim-devicons'}



-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if PACKER_BOOTSTRAP then
  require("packer").sync()
end
-- vim: ts=2 sw=2 et

--[[return require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}
	use {'sainnhe/gruvbox-material' }
	use {'neovim/nvim-lspconfig'}
	use {'nvim-lua/completion-nvim'}
	use {'tjdevries/nlua.nvim'}
	use {'tpope/vim-dispatch'}
	use {'tpope/vim-fugitive'}
	use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
	use {'lewis6991/gitsigns.nvim', 
		config = function()
			require('gitsigns').setup()
		end
	}
end)]]
