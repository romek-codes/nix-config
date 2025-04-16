-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  {
    import = "astrocommunity.pack.lua",
    opts = {
      -- Set lua_ls as optional since it's managed by NixOS
      config = {
        lua_ls = false
      }
    },
  },

  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.vue" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.laravel" },
  -- Override phpactor with intelephense and php-cs-fixer with pint.
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- Replace phpactor with intelephense by first filtering out phpactor and then adding intelephense
      opts.ensure_installed = vim.tbl_filter(function(item) 
        return item ~= "phpactor" 
      end, opts.ensure_installed)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "intelephense" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      -- Remove php-cs-fixer by filtering
      opts.ensure_installed = vim.tbl_filter(function(item) 
        return item ~= "php-cs-fixer" 
      end, opts.ensure_installed)
      -- Add pint
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "pint" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      -- Remove phpactor and php-cs-fixer by filtering
      opts.ensure_installed = vim.tbl_filter(function(item) 
        return item ~= "phpactor" and item ~= "php-cs-fixer"
      end, opts.ensure_installed)
      -- Add intelephense and pint
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "intelephense", "php-debug-adapter", "pint" }
      )
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "pint" },
      },
    },
  },
}
