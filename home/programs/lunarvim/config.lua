-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.builtin.nvimtree.setup.view.side = "right"

require('lspconfig').lua_ls.setup({})
require 'lspconfig'.tsserver.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}
require('lspconfig').eslint.setup({})
require('lspconfig').intelephense.setup({})
-- require('lspconfig').emmet_ls.setup({})
require('lspconfig').tailwindcss.setup({})
require('lspconfig').volar.setup({})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "pint" }, { name = "lua_format" }, { name = "prettier" } }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { name = "phpstan" }, { name = "luacheck" } }
-- , { name = "tlint" }

vim.opt.conceallevel = 2
lvim.format_on_save.enabled = true
vim.diagnostic.config({ virtual_text = false })

local Path = require("plenary.path")

local workspacePaths = {
  { name = "personal", path = "/media/romek/HDD 930GB/notes/personal" },
  { name = "personal", path = "/mnt/DE62EBAD62EB891B/notes/personal/" },
  { name = "work",     path = "/mnt/DE62EBAD62EB891B/notes/work" },
  { name = "work",     path = "/media/romek/HDD 930GB/notes/work" },
  { name = "work",     path = "/mnt/c/Users/Roman/notes/work" }
}

local workspaces = {}

for _, workspaceInfo in ipairs(workspacePaths) do
  local workspacePath = workspaceInfo.path
  if Path:new(workspacePath):exists() then
    local workspace = { name = workspaceInfo.name, path = workspacePath }
    table.insert(workspaces, workspace)
  end
end

lvim.plugins = {
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function() require("lsp_lines").setup() end
  },
  { "brenoprata10/nvim-highlight-colors" },
  { "xiyaowong/transparent.nvim" },

  { "EdenEast/nightfox.nvim" },
  { "danymat/neogen",                    config = true, version = "*" },
  -- {
  --     "epwalsh/obsidian.nvim",
  --     version = "*", -- recommended, use latest release instead of latest commit
  --     lazy = false,
  --     ft = "markdown",
  --     dependencies = {
  --         -- Required.
  --         "nvim-lua/plenary.nvim"
  --         -- see below for full list of optional dependencies 👇
  --     },
  --     opts = {
  --         -- Modify paths for your use case
  --         workspaces = workspaces
  --         -- see below for full list of options 👇
  --     }
  -- }, -- Add this closing brace
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "echasnovski/mini.icons" },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function() require("oil").setup() end

  }

}
require('nightfox').setup()
lvim.colorscheme = "carbonfox"

-- Ensure termguicolors is enabled if not already
vim.opt.termguicolors = true
require('nvim-highlight-colors').setup({})

require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = {                   -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {},   -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})

lvim.keys.normal_mode["<leader>ld"] = ":lua vim.diagnostic.setqflist()<CR>"

vim.keymap.set(
  "",
  "<Leader>lh",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)

-- TODO: Create command for neogen with which_key, to generate PHP DOCS
-- :Neogen
-- lvim.builtin.which_key.mappings["l"] = {
--     vim.cmd([[
--   p = { function()
--     lua require('neogen').generate()
--   ]])
--   end, "Generate documentation" },
-- }
-- TODO: Setup obsidian commands to search in all vaults.
-- :ObsidianSearch, :ObsidianOpen
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
