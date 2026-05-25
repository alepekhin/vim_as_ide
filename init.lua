-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/olimorris/codecompanion.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
})

require('dapui').setup()

require('nvim-treesitter').install { 'java', 'yaml' }

require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = {
        name = "ollama",
        model = "qwen3.5:9b"
      },
    },
    inline = {
      adapter = {
        name = "ollama",
        model = "qwen3.5:9b"
      },
    },
  },
  mcp = {
    servers = {
      ["duckduckgo-mcp-server"] = {
        --cmd = { "uvx", "duckduckgo-mcp-server" },
        cmd = { "duckduckgo-mcp-server" },
      },
    },
    opts = {
      default_servers = { "duckduckgo-mcp-server" },
    },
  },
  opts = {
    log_level = "DEBUG",
  },
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
vim.keymap.set('n', '<Leader>d', '<C-]>', { noremap = true, silent = true, desc = 'Go to declaration' })
vim.keymap.set('n', '<Leader>i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true, desc = 'Go to implementation' })
vim.keymap.set('n', '<Leader>s', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true, desc = 'Signature help' })
vim.keymap.set('n', '<Leader>a', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = 'Open code action' })
vim.keymap.set('n', '<Leader>h', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true, desc = 'Hover' })
vim.keymap.set('n', '<Leader>r', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true, desc = 'Rename' })
vim.keymap.set('n', '<Leader>c', ':CodeCompanionChat<CR>50<C-w>|', { noremap = true, silent = true, desc = 'Code companion' })
vim.keymap.set('n', '<Leader>t', ':new term://bash<CR>', { noremap = true, silent = true, desc = 'Open terminal' })

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

local dap = require('dap')
dap.adapters.java = {
  type = 'executable';
  command = '/home/alepekhin/projects/Github/jls/dist/debug_adapter_linux.sh';
}
dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
    sourceRoots = {os.getenv("SOURCE_ROOT")};
  },
}
