-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:
---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
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

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
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
  { 'echasnovski/mini.files', version = false },
  { "nvim-telescope/telescope-live-grep-args.nvim"},

}
