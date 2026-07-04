return {
  -- Plugin: opencode.nvim
  "nickjvandyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    -- Configure opencode options
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open("opencode --port", {
            win = { position = "right", enter = false },
          })
        end,
      },
    }

    -- Enable autoread for reload
    vim.o.autoread = true
  end,
}
