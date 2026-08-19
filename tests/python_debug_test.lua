--- Headless integration test for the Python (debugpy) debugger.
---
--- Verifies, against the real project config:
---   1. nvim-dap loads and the python adapter + launch config are registered
---   2. a breakpoint can be toggled
---   3. a launch session stops at the breakpoint
---   4. a local variable evaluates to the expected value
---
--- Usage:
---   nvim --headless -u config/nvim/init.lua -l tests/python_debug_test.lua <python-file> <output-file>
local src = assert(arg[1], "missing python file argument")
local out = assert(arg[2], "missing output file argument")

local results = {}
local passed = true

local function check(cond, msg)
  results[#results + 1] = (cond and "PASS" or "FAIL") .. ": " .. msg
  if not cond then
    passed = false
  end
end

local function finish(code)
  local f = assert(io.open(out, "w"))
  f:write(table.concat(results, "\n"), "\n")
  f:close()
  vim.cmd("cquit " .. code)
end

-- wait for the dap plugin (LazyVim lazy-loads it)
local dap
for _ = 1, 300 do
  local ok, mod = pcall(require, "dap")
  if ok and mod then
    dap = mod
    break
  end
  vim.wait(100)
end

if not dap then
  check(false, "nvim-dap plugin loaded")
  finish(1)
  return
end
check(true, "nvim-dap plugin loaded")

-- wait for the project config to register the python adapter + configurations
for _ = 1, 300 do
  if dap.adapters.python and dap.configurations.python then
    break
  end
  vim.wait(100)
end
check(dap.adapters.python ~= nil, "python (debugpy) adapter registered")
check(dap.configurations.python ~= nil, "python configurations registered")

-- open the fixture and locate the breakpoint marker
vim.cmd("edit " .. vim.fn.fnameescape(src))
local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
local bp_line
for i, l in ipairs(lines) do
  if l:find("BREAKPOINT") then
    bp_line = i
  end
end
check(bp_line ~= nil, "breakpoint marker found in fixture")

-- record the stopped event reason
local stopped_reason
dap.listeners.after.event_stopped["python_debug_test"] = function(_, body)
  stopped_reason = body.reason
end

-- toggle a breakpoint and launch the first (launch) configuration
vim.api.nvim_win_set_cursor(0, { bp_line, 1 })
dap.toggle_breakpoint()
dap.run(dap.configurations.python[1])

-- wait for the session to stop at the breakpoint
local session
for _ = 1, 400 do
  vim.wait(100)
  session = dap.session()
  if session and session.stopped_thread_id then
    break
  end
end

if not (session and session.stopped_thread_id) then
  check(false, "debug session stopped at breakpoint")
  finish(1)
  return
end

check(true, "debug session started and stopped")
check(
  stopped_reason == "breakpoint",
  "stopped with reason 'breakpoint' (got: " .. tostring(stopped_reason) .. ")"
)

-- wait for the stack frame to be resolved, then check the cursor position
for _ = 1, 100 do
  if session.current_frame then
    break
  end
  vim.wait(100)
end
check(session.current_frame ~= nil, "debug session loaded stack frame")

local line = vim.api.nvim_win_get_cursor(0)[1]
check(line == bp_line, "cursor stopped at breakpoint line " .. bp_line .. " (got line " .. line .. ")")

-- evaluate a local variable at the current frame (add(2, 3) -> x == 5)
local eval_result
local eval_err
session:evaluate("x", function(err, resp)
  eval_err = err
  eval_result = resp and resp.result
end)
for _ = 1, 100 do
  if eval_result ~= nil or eval_err ~= nil then
    break
  end
  vim.wait(100)
end

if eval_err then
  check(false, "variable evaluation: " .. tostring(eval_err))
elseif eval_result == nil then
  check(false, "variable evaluation returned no result")
else
  check(true, "evaluated x = " .. tostring(eval_result))
  check(tostring(eval_result) == "5", "x equals 5 (expected 2 + 3)")
end

-- cleanup: terminate the debuggee and exit
session:disconnect({ terminateDebuggee = true }, function() end)
vim.wait(300)
finish(passed and 0 or 1)