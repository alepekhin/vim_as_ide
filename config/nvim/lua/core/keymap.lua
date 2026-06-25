vim.diagnostic.config({
    virtual_text = true,
})

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

vim.cmd('colorscheme desert')
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

-- back to normal mode from terminal
vim.cmd('tnoremap <Esc> <C-\\><C-n>')

vim.keymap.set('i', '<C-p><C-p>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Back to normal mode' })
vim.keymap.set('n', '<Leader><Leader>', '<C-w><C-w>', { noremap = true, silent = true, desc = 'Next window' })
vim.keymap.set('n', '<Leader>t', ':new term://bash<CR>', { noremap = true, silent = true, desc = 'Open terminal' })
vim.keymap.set('n', '<Leader>a', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = 'jls: code action' })
vim.keymap.set('n', '<Leader>b', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true, desc = 'jls: go to implementation' })
vim.keymap.set('n', '<Leader>c', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true, desc = 'jls: signature help' })
vim.keymap.set('n', '<Leader>d', '<C-]>', { noremap = true, silent = true, desc = 'jls: Go to declaration' })
vim.keymap.set('n', '<Leader>e', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true, desc = 'jls: hover' })
vim.keymap.set('n', '<Leader>f', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true, desc = 'jls: rename' })
vim.keymap.set('n', '<Leader>g', ':lua require("opencode").toggle()<CR>', { noremap = true, silent = true, desc = 'opencode: toggle' })
vim.keymap.set('n', '<Leader>i', ':lua require("opencode").select()<CR>', { noremap = true, silent = true, desc = 'opencode: menu' })
vim.keymap.set('n', '<Leader>j', ':DapNew<CR>', { noremap = true, silent = true, desc = 'dap: new' })
vim.keymap.set('n', '<Leader>k', ':DapToggleBreakpoint<CR>', { noremap = true, silent = true, desc = 'dap: toggle breakpoint' })
vim.keymap.set('n', '<Leader>l', ':lua require("dapui").open()<CR>', { noremap = true, silent = true, desc = 'dap: open dapui' })
vim.keymap.set('n', '<Leader>m', ':lua require("dapui").close()<CR>', { noremap = true, silent = true, desc = 'dap: close dapui' })
vim.keymap.set('n', '<Leader>n', ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true, desc = 'buffer_manager:ui' })

-- my key help
vim.keymap.set('n', '<Leader>k', ':new +set\\ noma|set\\ ro ~/.config/nvim/keys<CR>', { noremap = true, silent = true, desc = 'Open keys file' })



