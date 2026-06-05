vim.pack.add({
  "https://github.com/nickjvandyke/opencode.nvim",
  -- Optional but recommended; remove if you already manage snacks.nvim elsewhere
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  input = {}, -- Enhances ask() prompts with completions, highlights, normal mode
  picker = {
    actions = {
      opencode_send = function(...)
        return require("opencode").snacks_picker_send(...)
      end,
    },
    win = {
      input = {
        keys = {
          ["<C-s>"] = { "opencode_send", mode = { "n", "i" } },
        },
      },
    },
  },
})

vim.g.opencode_opts = {
  server = {
    start = function()
      require("snacks.terminal").open("opencode --port", {
        win = { position = "right", enter = false },
      })
    end,
  },
}

vim.o.autoread = true -- Required for `opts.events.reload`


