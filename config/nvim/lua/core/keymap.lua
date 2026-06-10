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
vim.keymap.set('n', '<Leader>ja', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = 'jls: code action' })
vim.keymap.set('n', '<Leader>b', ':lua require("opencode").toggle()<CR>', { noremap = true, silent = true, desc = 'opencode: toggle' })
vim.keymap.set('n', '<Leader>jd', '<C-]>', { noremap = true, silent = true, desc = 'jls: Go to declaration' })
vim.keymap.set('n', '<Leader>e', ':lua require("opencode").select()<CR>', { noremap = true, silent = true, desc = 'opencode: menu' })
vim.keymap.set('n', '<Leader>ji', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true, desc = 'jls: go to implementation' })
vim.keymap.set('n', '<Leader>js', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true, desc = 'jls: signature help' })
vim.keymap.set('n', '<Leader>jh', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true, desc = 'jls: hover' })
vim.keymap.set('n', '<Leader>jr', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true, desc = 'jls: rename' })
vim.keymap.set('n', '<Leader>t', ':new term://bash<CR>', { noremap = true, silent = true, desc = 'Open terminal' })
vim.keymap.set('n', '<Leader>dn', ':DapNew<CR>', { noremap = true, silent = true, desc = 'dap: new' })
vim.keymap.set('n', '<Leader>db', ':DapToggleBreakpoint<CR>', { noremap = true, silent = true, desc = 'dap: toggle breakpoint' })
vim.keymap.set('n', '<Leader>do', ':lua require("dapui").open()<CR>', { noremap = true, silent = true, desc = 'dap: open dapui' })
vim.keymap.set('n', '<Leader>dc', ':lua require("dapui").close()<CR>', { noremap = true, silent = true, desc = 'dap: close dapui' })

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


