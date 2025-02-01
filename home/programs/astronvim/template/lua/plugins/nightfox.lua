-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "EdenEast/nightfox.nvim",
  opts = {
    -- change colorscheme
    colorscheme = "carbonfox",
    palettes = {
      carbonfox = {
        bg1 = "#0C0C0C",
      },
    },
  },
}
