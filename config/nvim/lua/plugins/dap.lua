vim.pack.add({
	'https://github.com/nvim-nio',
        'https://github.com/nvim-dap',
        'https://github.com/nvim-dap-ui',
})


require('dapui').setup()

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

