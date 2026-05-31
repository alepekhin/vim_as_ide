vim.pack.add({
    'https://github.com/plenary.nvim',
    'https://github.com/codecompanion.nvim',
})

require("codecompanion").setup({
    adapters = {
        http = {
            ["kimi"] = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        type = "openai_legacy",
                        base_url = "http://10.0.0.9:8027/v1", -- address under Yan VPN
                        api_key = "test",
                        reasoning_key = "reasoning",
                    },
                    handlers = {
                        parse_message_meta = function(self, data)
                            local extra = data.extra
                            if extra and extra.reasoning_content then
                                data.output.reasoning = { content = extra.reasoning_content }
                                if data.output.content == "" then
                                    data.output.content = nil
                                end
                            end
                            return data
                        end,
                    },
                })
            end,
        },
    },
    interactions = {
        chat = {
--            adapter = "ollama",
--            model = "qwen3.5:9b",
            adapter = "kimi",
            model = "Kimi-K2.6",
        },
        inline = {
--            adapter = "ollama",
--            model = "qwen3.5:9b",
            adapter = "kimi",
            model = "Kimi-K2.6",
        },
    },
    mcp = {
        servers = {
            ["duckduckgo-mcp-server"] = {
                cmd = { "duckduckgo-mcp-server" },
            },
        },
        opts = {
            default_servers = { "duckduckgo-mcp-server" },
        },
    },
    opts = {
        log_level = "DEBUG",
    },
})


