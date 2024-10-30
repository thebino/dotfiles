return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = function()
            local harpoon = require("harpoon")
            local conf = require("telescope.config").values

            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end
                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end


            return {
                -- Harpoon next and previous.
                {"<leader>bn", function() harpoon:list():next() end, desc ="Next buffer"},
                {"<leader>bp", function() harpoon:list():prev() end, desc ="Prev buffer"},

                -- Harpoon user interface.
                {"<leader>ba", function() harpoon:list():add() end, desc ="Harpoon file"},

                -- Use Telescope as Harpoon user interface.
                {"<leader>bh", function() toggle_telescope(harpoon:list() )end, desc ="Open Harpoon"},
            }
        end,


        opts = function(_, opts)
            opts.settings = {
                save_on_toggle = false,
                sync_on_ui_close = false,
                save_on_change = true,
                enter_on_sendcmd = false,
                tmux_autoclose_windows = false,
                excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
                mark_branch = false,
                key = function()
                    return vim.loop.cwd()
                end
            }
        end,


        config = function(_, opts)
            require("harpoon").setup(opts)
        end,

    }
}

