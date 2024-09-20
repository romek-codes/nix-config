-- General Settings
vim.opt.termguicolors = true
vim.opt.conceallevel = 2
vim.wo.relativenumber = true
vim.diagnostic.config({ virtual_text = false })

-- LunarVim Settings
lvim.format_on_save.enabled = true
lvim.colorscheme = "carbonfox"
lvim.builtin.nvimtree.setup.view.side = "right"

-- LSP Configuration
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({})
lspconfig.tsserver.setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = { "javascript", "typescript", "vue" },
})
lspconfig.eslint.setup({})
lspconfig.intelephense.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.volar.setup({})

-- Null-LS Configuration
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({ { name = "pint" }, { name = "lua_format" }, { name = "prettier" } })

local linters = require "lvim.lsp.null-ls.linters"
linters.setup({ { name = "phpstan" }, { name = "luacheck" } })

-- Workspaces Configuration
local Path = require("plenary.path")
local workspacePaths = {
  { name = "personal", path = "/mnt/hdd-1tb/notes/personal" },
  { name = "work",     path = "/mnt/hdd-1tb/notes/work" },
}
local workspaces = {}
for _, workspaceInfo in ipairs(workspacePaths) do
  local workspacePath = workspaceInfo.path
  if Path:new(workspacePath):exists() then
    table.insert(workspaces, { name = workspaceInfo.name, path = workspacePath })
  end
end

-- Plugin Configuration
lvim.plugins = {
  {
    'romek-codes/bruno.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('bruno').setup({
        collection_paths = {
          { name = "Nix",          path = "/home/romek/Bruno" },
          { name = "Windows-work", path = "/mnt/c/Users/Roman/Documents/Bruno" },
        }
      })
    end
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function() require("lsp_lines").setup() end
  },
  { "EdenEast/nightfox.nvim" },
  {
    "danymat/neogen",
    config = true,
    version = "*"
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    opts = {
      workspaces = workspaces,
      ui = { enable = false },
    },
    lazy = false,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("oil").setup() end
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    main = "render-markdown",
    opts = { bullet = { right_pad = 10 } },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  },
  { 'brenoprata10/nvim-highlight-colors' },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    }
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({});
    end
  },
}

-- Nightfox and Highlight Colors Setup
require('nightfox').setup()
require('nvim-highlight-colors').setup({})

-- Noice Configuration
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
  messages = {
    view = "mini",
    view_warn = "mini",
    view_error = "mini",
  },
})

-- Keybindings
lvim.builtin.which_key.mappings["lp"] = {
  name = "PHP",
  g = { function() require('neogen').generate() end, "Generate documentation" },
  c = { function() require('neogen').generate({ type = "class" }) end, "Generate class documentation" },
  f = { function() require('neogen').generate({ type = "func" }) end, "Generate function documentation" },
}

lvim.builtin.which_key.mappings["lh"] = {
  function() require("lsp_lines").toggle() end, "Toggle_lsp_lines"
}

-- Remove the existing "ld" mapping if it exists
lvim.builtin.which_key.mappings["l"]["d"] = nil
-- Add the new "ld" mapping
lvim.builtin.which_key.mappings["l"]["d"] = { ":lua vim.diagnostic.setqflist()<CR>", "Show issues" }
lvim.keys.normal_mode["<leader>ld"] = ":lua vim.diagnostic.setqflist()<CR>"


lvim.builtin.which_key.mappings["o"] = {
  name = "Obsidian",
  s = { "<cmd>ObsidianSearch<cr>", "Search" },
  o = { "<cmd>ObsidianOpen<cr>", "Open" },
  t = { "<cmd>ObsidianTags<cr>", "Tags" },
  n = { "<cmd>ObsidianNew<cr>", "New note" },
  b = { "<cmd>ObsidianBacklinks<cr>", "Backlinks" },
}

lvim.builtin.which_key.mappings["n"] = {
  name = "Noice",
  h = { "<cmd>Noice history<cr>", "History" },
  d = { "<cmd>Noice dismiss<cr>", "Dismiss" },
  l = { "<cmd>Noice last<cr>", "Last message" },
  e = { "<cmd>Noice errors<cr>", "Errors" },
}

lvim.builtin.which_key.mappings["B"] = {
  name = "Bruno",
  r = { "<cmd>BrunoRun<cr>", "Run" },
  e = { "<cmd>BrunoEnv<cr>", "Environment" },
  s = { "<cmd>BrunoSearch<cr>", "Search" },
}
