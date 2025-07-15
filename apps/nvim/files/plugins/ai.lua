return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            input = {
                provider = "snacks",
            },
            selector = {
                provider = "snacks",
                provider_opts = {},
            },
            auto_suggestions_provider = "copilot",
            behaviour = {
                -- auto_suggestions = true,
                jump_result_buffer_on_finish = true,
                auto_focus_on_diff_view = true,
                enable_token_counting = false,
                enable_cursor_planning_mode = true,
            },
            mappings = {
                sidebar = {
                    close_from_input = { normal = "q", insert = "<C-d>" },
                },
            },
            provider = "copilot",
            cursor_applying_provider = "copilot",
            providers = {
                ollama = {
                    ezqndpoint = "http://localhost:11434",
                    model = "mistral",
                    -- model = "qwq:32b",
                    timeout = 30000, -- Timeout in milliseconds
                    extra_request_body = {
                        temperature = 0.75,
                        num_ctx = 20480,
                        keep_alive = "5m",
                    },
                },
                openai = {
                    endpoint = "https://api.openai.com/v1",
                    model = "gpt-4o",
                    timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
                    extra_request_body = {
                        temperature = 0,
                        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
                        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
                    }
                },
                copilot = {
                    model = "gpt-4o",
                },
                gemini = {
                    endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
                    model = "gemini-2.0-flash",
                    timeout = 30000, -- Timeout in milliseconds
                    context_window = 1048576,
                    use_ReAct_prompt = true,
                    extra_request_body = {
                        generationConfig = {
                            temperature = 0.75,
                        },
                    },
                },
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-opus-4-20250514",
                    timeout = 30000, -- Timeout in milliseconds
                    disable_tools = true, -- disable tools!
                    context_window = 1048576,
                    use_ReAct_prompt = true,
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 4096,
                    },
                },
                groq = {
                    endpoint = 'https://api.groq.com/openai/v1/',
                    model = 'llama-3.3-70b-versatile',
                    disable_tools = true,
                    extra_request_body = {
                        temperature = 1,
                        max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
                    }
                },
            }
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }
}

