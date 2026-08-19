# vim_as_ide

LazyVim is Neovim with all IDE plugins instaled

We changed Java Language Server to jls 
and make some other small changes

See lazyvim and opencode configuration in `config` folder

See vibe coded example for using jls features in `example` folder

## Python Debugger (debugpy)

Requirements: `debugpy` installed for your Python:

```bash
pip3 install --break-system-packages debugpy
```

### Launch (debug current file)

1. Open a Python file
2. Toggle a breakpoint: `<leader>db`
3. Start debugging: `:DapContinue` (or `:lua require("dap").continue()`)
4. Debug UI: `<leader>du` (open), `<leader>dc` (close)

### Attach (remote / running process)

1. Start your script with the debugger listening on port 5678:

   ```bash
   python3 -m debugpy --listen 5678 your_script.py
   ```

2. In nvim, choose the **Debug (Attach) - Remote** config:
   `:lua require("dap").continue()` then select it, or run it directly via
   `:lua require("dap").run({ config = ... })`

Configuration lives in `config/nvim/lua/plugins/dap.lua`.

### Test

The Python debugger has a headless integration test. It launches a real debug
session, hits a breakpoint, and checks a variable value:

```bash
tests/run_python_debug_test.sh
```

Requires `debugpy` (see above). Results are printed with PASS/FAIL lines and the
exit code reflects success.


