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
	{ noremap = true, silent = true, desc = "toggle breakpoint" }
)
vim.api.nvim_set_keymap("n", "<Leader>dg", ":DapContinue<CR>", { noremap = true, silent = true, desc = "continue" })
vim.api.nvim_set_keymap("n", "<Leader>dn", ":DapNew<CR>", { noremap = true, silent = true, desc = "new session" })

--  ############# opencode #####################

vim.keymap.set(
	"n",
	"<Leader>cO",
	':lua require("opencode").select()<CR>',
	{ noremap = true, silent = true, desc = "opencode" }
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
	"<Leader>ca",
	":lua vim.lsp.buf.code_action()<CR>",
	{ noremap = true, silent = true, desc = "code action" }
)
vim.keymap.set(
	"n",
	"<Leader>ci",
	":lua vim.lsp.buf.implementation()<CR>",
	{ noremap = true, silent = true, desc = "go to implementation" }
)
vim.keymap.set(
	"n",
	"<Leader>cs",
	":lua vim.lsp.buf.signature_help()<CR>",
	{ noremap = true, silent = true, desc = "signature help" }
)
vim.keymap.set("n", "<Leader>cd", "<C-]>", { noremap = true, silent = true, desc = "Go to declaration" })
vim.keymap.set("n", "<Leader>ch", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "hover" })
--vim.keymap.set("n", "<Leader>cn", ":lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true, desc = "rename" })
vim.keymap.set(
	"n",
	"<Leader>cu",
	":lua vim.lsp.buf.references()<CR>",
	{ noremap = true, silent = true, desc = "references" }
)
