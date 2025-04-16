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

-- Plugin Configuration
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "live-grep-args")
end
lvim.builtin.which_key.mappings["st"] = {
  "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args{}<CR>", "Text"
}

-- Keybindings

lvim.builtin.telescope.defaults = {
  path_display = { "absolute" },
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.99,
    height = 0.99,
    prompt_position = "top",
  },
}
