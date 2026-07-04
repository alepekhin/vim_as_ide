-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--  ############# dap #####################

vim.api.nvim_set_keymap(
  "n",
  "<leader>du",
  '<cmd>lua require("dapui").open()<CR>',
  { noremap = true, silent = true, desc = "dap-ui open" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>dc",
  '<cmd>lua require("dapui").close)<CR>',
  { noremap = true, silent = true, desc = "dap-ui close" }
)
vim.api.nvim_set_keymap(
  "n",
  "<Leader>db",
  ":DapToggleBreakpoint<CR>",
  { noremap = true, silent = true, desc = "dap: toggle breakpoint" }
)
vim.api.nvim_set_keymap("n", "<Leader>dn", ":DapNew<CR>", { noremap = true, silent = true, desc = "dap: new" })

--  ############# opencode #####################

vim.keymap.set(
  "n",
  "<Leader>co",
  ':lua require("opencode").select()<CR>',
  { noremap = true, silent = true, desc = "opencode: menu" }
)

--  ############# markdown #####################

vim.keymap.set("n", "<leader>ct", function()
  local conceallevel = vim.api.nvim_get_option_value("conceallevel", {})
  local new_level = conceallevel == 0 and 1 or 0
  vim.api.nvim_set_option_value("conceallevel", new_level, {})
  print("conceallevel set to", new_level)
end, { desc = "Toggle conceallevel" })

--  ############# jls #####################
vim.keymap.set(
  "n",
  "<Leader>ja",
  ":lua vim.lsp.buf.code_action()<CR>",
  { noremap = true, silent = true, desc = "jls: code action" }
)
vim.keymap.set(
  "n",
  "<Leader>ji",
  ":lua vim.lsp.buf.implementation()<CR>",
  { noremap = true, silent = true, desc = "jls: go to implementation" }
)
vim.keymap.set(
  "n",
  "<Leader>js",
  ":lua vim.lsp.buf.signature_help()<CR>",
  { noremap = true, silent = true, desc = "jls: signature help" }
)
vim.keymap.set("n", "<Leader>jd", "<C-]>", { noremap = true, silent = true, desc = "jls: Go to declaration" })
vim.keymap.set(
  "n",
  "<Leader>jh",
  ":lua vim.lsp.buf.hover()<CR>",
  { noremap = true, silent = true, desc = "jls: hover" }
)
vim.keymap.set(
  "n",
  "<Leader>jn",
  ":lua vim.lsp.buf.rename()<CR>",
  { noremap = true, silent = true, desc = "jls: rename" }
)
vim.keymap.set(
  "n",
  "<Leader>jr",
  ":lua vim.lsp.buf.references()<CR>",
  { noremap = true, silent = true, desc = "jls: references" }
)
