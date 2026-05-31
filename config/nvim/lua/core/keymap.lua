vim.diagnostic.config({
    virtual_text = true,
})

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

vim.cmd('colorscheme desert')
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

vim.keymap.set('n', '<Leader><Leader>', '<C-w><C-w>', { noremap = true, silent = true, desc = 'Next window' })
vim.keymap.set('n', '<Leader>a', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = 'jls: code action' })
vim.keymap.set('n', '<Leader>b', ':lua require("opencode").toggle()<CR>', { noremap = true, silent = true, desc = 'opencode: toggle' })
vim.keymap.set('n', '<Leader>c', ':CodeCompanionChat<CR>50<C-w>|', { noremap = true, silent = true, desc = 'Code companion' })
vim.keymap.set('n', '<Leader>d', '<C-]>', { noremap = true, silent = true, desc = 'jls: Go to declaration' })
vim.keymap.set('n', '<Leader>e', ':lua require("opencode").select()<CR>', { noremap = true, silent = true, desc = 'opencode: menu' })
vim.keymap.set('n', '<Leader>i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true, desc = 'Go to implementation' })
vim.keymap.set('n', '<Leader>s', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true, desc = 'Signature help' })
vim.keymap.set('n', '<Leader>h', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true, desc = 'Hover' })
vim.keymap.set('n', '<Leader>r', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true, desc = 'Rename' })
vim.keymap.set('n', '<Leader>t', ':new term://bash<CR>', { noremap = true, silent = true, desc = 'Open terminal' })
vim.keymap.set('n', '<Leader>x', ':lua require("dapui").open()<CR>', { noremap = true, silent = true, desc = 'Open dapui' })
vim.keymap.set('n', '<Leader>y', ':lua require("dapui").close()<CR>', { noremap = true, silent = true, desc = 'Close dapui' })

-- my key help
vim.keymap.set('n', '<Leader>k', ':new +set\\ noma|set\\ ro ~/.config/nvim/keys<CR>', { noremap = true, silent = true, desc = 'Open keys file' })


-- Execute Ctrl-N after 3 symbols printed
vim.api.nvim_create_autocmd("InsertCharPre", {
    callback = function()
        -- Get current line content up to cursor
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]

        -- Check if we have 3 characters in the current word
        local current_word = string.match(line:sub(1, col), "%S+$") or ""
        if #current_word == 2 then -- Using 2 because the 3rd char is about to be added
            -- Feed Ctrl-N after the current character is inserted
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-N>", true, false, true), "m", true)
        end
    end
})


