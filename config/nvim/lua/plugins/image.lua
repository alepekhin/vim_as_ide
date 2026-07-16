return {
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- or "wezterm" depending on your terminal
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.heic", "*.HEIC" },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 100,
      kitty_method = "normal",
    },
  },
}
