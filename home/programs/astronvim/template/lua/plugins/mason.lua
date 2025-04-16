-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    optional = false,
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- Filter out lua_ls from ensure_installed if it exists
      if opts.ensure_installed then
        opts.ensure_installed = vim.tbl_filter(
          function(server) return server ~= "lua_ls" end,
          opts.ensure_installed
        )
      end
    end
    -- ensure_installed = {
      -- "lua_ls",
      -- add more arguments for adding more language servers
    -- },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        -- "python",
        -- add more arguments for adding more debuggers
      },
    },
  }
}
