-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap(
  "n",
  "<leader>dui",
  '<cmd>lua require("dapui").open()<CR>',
  { noremap = true, silent = true, desc = "dap-ui open" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>duc",
  '<cmd>lua require("dapui").close)<CR>',
  { noremap = true, silent = true, desc = "dap-ui close" }
)
vim.api.nvim_set_keymap(
  "n",
  "<Leader>dub",
  ":DapToggleBreakpoint<CR>",
  { noremap = true, silent = true, desc = "dap: toggle breakpoint" }
)
vim.api.nvim_set_keymap("n", "<Leader>dus", ":DapNew<CR>", { noremap = true, silent = true, desc = "dap: new" })
vim.keymap.set(
  "n",
  "<Leader>g",
  ':lua require("opencode").toggle()<CR>',
  { noremap = true, silent = true, desc = "opencode: toggle" }
)
vim.keymap.set(
  "n",
  "<Leader>i",
  ':lua require("opencode").select()<CR>',
  { noremap = true, silent = true, desc = "opencode: menu" }
)
