vim.pack.add({
  "https://github.com/nickjvandyke/opencode.nvim",
  -- Optional but recommended; remove if you already manage snacks.nvim elsewhere
  "https://github.com/folke/snacks.nvim",
})

-- Optional `snacks.nvim` integration for enhanced `ask()` and `select()`
local ok, snacks = pcall(require, "snacks")
if ok then
  snacks.setup({
    input = {}, -- Enhances `ask()`
    picker = { -- Enhances `select()`
      actions = {
        opencode_send = function(...)
          return require("opencode").snacks_picker_send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
      },
    },
  })
end

---@type opencode.Opts
vim.g.opencode_opts = {
  -- Your configuration, if any; goto definition on the type or field for details
}

vim.o.autoread = true -- Required for `opts.events.reload`


