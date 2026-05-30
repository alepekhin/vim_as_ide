-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
        'https://github.com/nvim-tree.lua',
})

require("nvim-tree").setup({
    renderer = {
        icons = {
            show = {
                file = false,
                folder = true,
                folder_arrow = true,
                git = false,
            },
        },
    },
})


