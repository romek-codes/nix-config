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
  { import = "astrocommunity.pack.laravel" },
  { import = "astrocommunity.pack.nix" },
  -- import/override with your plugins folder
}
