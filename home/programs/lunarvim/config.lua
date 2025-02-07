-- General Settings
vim.opt.termguicolors = true
vim.opt.conceallevel = 2
vim.wo.relativenumber = true
vim.diagnostic.config({ virtual_text = false })
-- Line wrap settings
vim.o.textwidth = 0
vim.o.wrapmargin = 0
vim.o.wrap = true
vim.o.linebreak = true

-- LunarVim Settings
lvim.format_on_save.enabled = true
-- lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.active = false

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

-- LSP Configuration
local lspconfig = require("lspconfig")

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
lspconfig.stimulus_ls.setup({})

-- Null-LS Configuration
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "pint" },
  { name = "blade-formatter" },
  { name = "lua_format" },
  { name = "prettier" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { name = "phpstan" },
  { name = "luacheck" },
  { name = "tlint" },
})

-- Workspaces Configuration
local Path = require("plenary.path")
local workspacePaths = {
  -- meshify
  { name = "personal", path = "/mnt/hdd-1tb/notes/personal" },
  { name = "work",     path = "/mnt/hdd-1tb/notes/work" },
  -- lenovo-yoga
  { name = "personal", path = "/home/romek/notes/personal" },
  { name = "work",     path = "/home/romek/notes/work" }
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
    "romek-codes/bruno.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("bruno").setup({
        collection_paths = {
          { name = "Nix",          path = "~/Bruno" },
          { name = "Windows-work", path = "/mnt/c/Users/Roman/Documents/Bruno" },
        },
      })
    end,
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    "danymat/neogen",
    config = true,
    version = "*",
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
}
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "live-grep-args")
end
lvim.builtin.which_key.mappings["st"] = {
  "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args{}<CR>", "Text"
}

require("nvim-highlight-colors").setup({})
require('mini.files').setup()

-- Keybindings
lvim.builtin.which_key.mappings["lp"] = {
  name = "PHP",
  g = {
    function()
      require("neogen").generate()
    end,
    "Generate documentation",
  },
  c = {
    function()
      require("neogen").generate({ type = "class" })
    end,
    "Generate class documentation",
  },
  f = {
    function()
      require("neogen").generate({ type = "func" })
    end,
    "Generate function documentation",
  },
}

lvim.builtin.which_key.mappings["lh"] = {
  function()
    require("lsp_lines").toggle()
  end,
  "Toggle_lsp_lines",
}

lvim.builtin.which_key.mappings["e"] = nil
lvim.builtin.which_key.mappings["e"] = {
  ":lua MiniFiles.open()<cr>",
  "Show explorer",
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
  g = { "<cmd>ObsidianFollowLink<cr>", "Follow link" },
  -- b = { "<cmd>ObsidianBacklinks<cr>", "Backlinks" },
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

lvim.builtin.telescope.defaults = {
  path_display = { "absolute" },
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.99,
    height = 0.99,
    prompt_position = "top",
  },
}
