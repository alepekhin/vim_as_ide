return {
  -- Plugin: opencode.nvim
  "nickjvandyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    -- Setup snacks.nvim
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
