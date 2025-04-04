-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:
---@type LazySpec
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

return {
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
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        [[                                __                             __                   ]],
        [[                               /\ \                           /\ \                  ]],
        [[ _ __   ___     ___ ___      __\ \ \/'\         ___    ___    \_\ \     __    ____  ]],
        [[/\`'__\/ __`\ /' __` __`\  /'__`\ \ , <        /'___\ / __`\  /'_` \  /'__`\ /',__\ ]],
        [[\ \ \//\ \L\ \/\ \/\ \/\ \/\  __/\ \ \\`\   __/\ \__//\ \L\ \/\ \L\ \/\  __//\__, `\]],
        [[ \ \_\\ \____/\ \_\ \_\ \_\ \____\\ \_\ \_\/\_\ \____\ \____/\ \___,_\ \____\/\____/]],
        [[  \/_/ \/___/  \/_/\/_/\/_/\/____/ \/_/\/_/\/_/\/____/\/___/  \/__,_ /\/____/\/___/ ]],
      }

      return opts
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
    "romek-codes/bruno.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("bruno").setup({
        collection_paths = {
          { name = "Nix",      path = "~/Bruno" },
          -- { name = "Windows-work", path = "/mnt/c/Users/Roman/Documents/Bruno" },
          { name = "Nix-work", path = "~/notes/work/Bruno" },
        },
      })
    end,
  },


  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim",       enabled = false },

  -- You can also easiy customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip" (plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs" (plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
          -- don't add a pair if the next character is %
              :with_pair(cond.not_after_regex "%%")
          -- don't add a pair if  the previous character is xxx
              :with_pair(
                cond.not_before_regex("xxx", 3)
              )
          -- don't move right when repeat character
              :with_move(cond.none())
          -- don't delete if the next character is xx
              :with_del(cond.not_after_regex "xx")
          -- disable adding a newline when you press <cr>
              :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = { bullet = { right_pad = 10 } },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  { "brenoprata10/nvim-highlight-colors" },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
    config = function()
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
    end,
  },
  { "nvim-lua/plenary.nvim" },
  { "nvim-pack/nvim-spectre" },
  { "echasnovski/mini.files",
    config = function()
      require("mini.files").setup()
    end,
  },
  { "nvim-telescope/telescope-live-grep-args.nvim",
  config = function ()
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")
    telescope.setup {
      extensions = {
        live_grep_args = {
          auto_quoting = true, 
          mappings = { 
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-f>"] = lga_actions.to_fuzzy_refine,
            },
          },
        }
      }
    }
  end
  },
  {
    "andymass/vim-matchup",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}


