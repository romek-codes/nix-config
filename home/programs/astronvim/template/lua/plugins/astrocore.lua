-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true,                                 -- enable autopairs at start
      cmp = true,                                       -- enable completion at start
      diagnostics_mode = 3,                             -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true,                              -- highlight URLs at start
      notifications = true,                             -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {                  -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true,         -- sets vim.opt.number
        spell = false,         -- sets vim.opt.spell
        signcolumn = "yes",    -- sets vim.opt.signcolumn to yes
        wrap = false,          -- sets vim.opt.wrap
      },
      g = {                    -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        -- PHP documentation generation
        ["<Leader>lpg"] = {
          function()
            require("neogen").generate()
          end,
          desc = "Generate documentation",
        },
        ["<Leader>lpc"] = {
          function()
            require("neogen").generate({ type = "class" })
          end,
          desc = "Generate class documentation",
        },
        ["<Leader>lpf"] = {
          function()
            require("neogen").generate({ type = "func" })
          end,
          desc = "Generate function documentation",
        },

        -- Toggle lsp_lines
        ["<Leader>lh"] = {
          function()
            require("lsp_lines").toggle()
          end,
          desc = "Toggle_lsp_lines",
        },

        -- Show explorer
        ["<Leader>e"] = { ":lua MiniFiles.open()<cr>", desc = "Show explorer" },

        -- Show issues
        ["<Leader>ld"] = { ":lua vim.diagnostic.setqflist()<CR>", desc = "Show issues" },

        -- Obsidian mappings
        ["<Leader>os"] = { "<cmd>ObsidianSearch<cr>", desc = "Search" },
        ["<Leader>oo"] = { "<cmd>ObsidianOpen<cr>", desc = "Open" },
        ["<Leader>ot"] = { "<cmd>ObsidianTags<cr>", desc = "Tags" },
        ["<Leader>on"] = { "<cmd>ObsidianNew<cr>", desc = "New note" },
        ["<Leader>og"] = { "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },

        -- Noice mappings
        ["<Leader>nh"] = { "<cmd>Noice history<cr>", desc = "History" },
        ["<Leader>nd"] = { "<cmd>Noice dismiss<cr>", desc = "Dismiss" },
        ["<Leader>nl"] = { "<cmd>Noice last<cr>", desc = "Last message" },
        ["<Leader>ne"] = { "<cmd>Noice errors<cr>", desc = "Errors" },

        -- Bruno mappings
        ["<Leader>Br"] = { "<cmd>BrunoRun<cr>", desc = "Run" },
        ["<Leader>Be"] = { "<cmd>BrunoEnv<cr>", desc = "Environment" },
        ["<Leader>Bs"] = { "<cmd>BrunoSearch<cr>", desc = "Search" },

        -- Spectre mappings
        ["<Leader>fr"] = { "<cmd>Spectre<cr>", desc = "Find & Replace" },

        ["<Leader>fw"] = { "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args{}<CR>", desc = "Find word" },

        -- Group descriptors for which-key
        ["<Leader>lp"] = { desc = "PHP" },
        ["<Leader>o"] = { desc = "Obsidian" },
        ["<Leader>n"] = { desc = "Noice" },
        ["<Leader>B"] = { desc = "Bruno" },
      },
    },
  },
}
