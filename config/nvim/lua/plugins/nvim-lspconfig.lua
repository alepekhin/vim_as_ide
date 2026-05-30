vim.pack.add({
        'https://github.com/nvim-lspconfig',
})

vim.lsp.config['jls'] = {
    -- absolute path here:
    cmd = { '/home/alepekhin/projects/Github/jls/dist/lang_server_linux.sh' },
    filetypes = { 'java' },
    root_markers = {  'build.gradle', 'pom.xml' , '.git', '.' },
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })
    end,
    settings = { 
        codelens = { enable = true }, 
        inlay_hint = { enable = true },
        linked_editing_range = { enable = true },
        inlay_hint = { enable = true },
        inline_completion = { enable = true }
    },
}

vim.lsp.enable('jls')


