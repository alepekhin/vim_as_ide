return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    --"nvim-neotest/nvim-nest",
  },
  config = function()
    local dap = require("dap")
    -- Define the Java adapter
    dap.adapters.java = {
      type = "executable",
      command = "/home/alepekhin/projects/Github/jls/dist/debug_adapter_linux.sh",
    }

    -- Set up configurations for Java debugging
    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
        sourceRoots = { os.getenv("SOURCE_ROOT") },
      },
    }
  end,
}
