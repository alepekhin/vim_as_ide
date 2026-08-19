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

    -- Define the Python (debugpy) adapter
    dap.adapters.python = {
      type = "executable",
      command = "python3",
      args = { "-m", "debugpy.adapter" },
    }

    -- Set up configurations for Python debugging
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Debug (Launch) - File",
        program = "${file}",
        console = "integratedTerminal",
        justMyCode = true,
        cwd = "${workspaceFolder}",
      },
      {
        type = "python",
        request = "attach",
        name = "Debug (Attach) - Remote",
        connect = { host = "127.0.0.1", port = 5678 },
        pathMappings = {
          { localRoot = "${workspaceFolder}", remoteRoot = "." },
        },
      },
    }
  end,
}
