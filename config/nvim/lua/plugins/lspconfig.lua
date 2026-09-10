local function dotted_word_at_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  for start, id in line:gmatch("()([%w_.]+)") do
    local stop = start + #id - 1
    if col >= start - 1 and col <= stop - 1 then
      return id
    end
  end
end

local function pydoc_fallback(word)
  local name = word:match("[%w_.]+")
  if not name or name == "" then
    return
  end
  if not name:match("%.") then
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      local module, imported = line:match("^%s*from%s+([%w_.]+)%s+import%s+([%w_,%s]+)")
      if module then
        for item in imported:gmatch("[%w_]+") do
          if item == name then
            name = module .. "." .. name
          end
        end
      end
    end
  end
  local alias, module = name:match("^([%w_]+)%.(.+)$")
  if alias then
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      local imported, as = line:match("^%s*import%s+([%w_.]+)%s+as%s+([%w_]+)")
      if imported and as == alias then
        name = imported .. "." .. module
        break
      end
    end
  end
  vim.system({ "python3", "-m", "pydoc", name }, { text = true }, function(obj)
    local out = (obj.stdout or ""):gsub("\r\n", "\n"):gsub("%s+$", "")
    vim.schedule(function()
      if obj.code ~= 0 or out:match("No Python documentation found") then
        vim.notify("No Python documentation found for '" .. name .. "'", vim.log.levels.INFO)
        return
      end
      vim.lsp.util.open_floating_preview(vim.split(out, "\n"), "text", { border = "rounded" })
    end)
  end)
end

local function hover_has_content(contents)
  if contents == nil then
    return false
  end
  if type(contents) == "string" then
    return contents ~= ""
  end
  if type(contents.value) == "string" then
    return contents.value ~= ""
  end
  if vim.tbl_islist(contents) then
    return #contents > 0
  end
  return true
end

local function python_hover()
  if vim.bo.filetype ~= "python" then
    return vim.lsp.buf.hover()
  end
  local word = dotted_word_at_cursor()
  local hover_clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" })
  if #hover_clients == 0 then
    pydoc_fallback(word)
    return
  end
  local client = hover_clients[1]
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client.request("textDocument/hover", params, function(err, result, ctx)
    if err or not hover_has_content(result and result.contents) then
      pydoc_fallback(word)
      return
    end
    vim.lsp.handlers.hover(nil, result, ctx, { border = "rounded" })
  end, 0)
end

return {
  "neovim/nvim-lspconfig",
  keys = {
    { "K", python_hover, desc = "Hover (pydoc fallback)", ft = "python" },
  },
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "K", python_hover, desc = "Hover (pydoc fallback)" },
        },
      },
      jls = {
        cmd = { "/home/alepekhin/projects/Github/jls/dist/lang_server_linux.sh" },
        filetypes = { "java" },
        root_markers = { "build.gradle", "pom.xml", ".git", "." },
        on_attach = function(client, bufnr)
          vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
              return { abbr = item.label:gsub("%b()", "") }
            end,
          })
        end,
        settings = {
          codelens = { enable = true },
          inlay_hint = { enable = true },
          linked_editing_range = { enable = true },
          inline_completion = { enable = true },
        },
      },
      basedpyright = {
        mason = false,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "basic",
            },
          },
        },
      },
      ruff = {},
    },
  },
}
