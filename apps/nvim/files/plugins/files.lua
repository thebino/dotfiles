return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        lazy = false,
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File explorer" },
        },
        opts = {
        },
        config = function()
            -- change color for arrows in tree to light blue
            vim.cmd.highlight("NvimTreeFolderArrowClosed guifg=#3FC5FF")
            vim.cmd.highlight("NvimTreeFolderArrowOpen guifg=#3FC5FF")

            require("nvim-tree").setup {
                sort = {},
                view = {
                    side = "left",
                    number = true,
                    relativenumber = true,
                    signcolumn = "auto",
                    width = {
                        min = 40,
                    },
                },
                renderer = {
                    highlight_git = "all",
                    highlight_opened_files = "name",
                    highlight_diagnostics = "name",
                    decorators = { "Git", "Open", "Hidden", "Modified", "Bookmark", "Diagnostics", "Copied", "Cut", },
                    hidden_display = "all",
                    -- hidden_stats
                    icons = {
                        git_placement = "signcolumn",
                        hidden_placement = "after",
                        modified_placement = "after",
                        bookmarks_placement = "before",
                        diagnostics_placement = "signcolumn",
                        padding = {
                            icon = " ",
                            folder_arrow = " ",
                        },
                        symlink_arrow = " -> ",
                        show = {
                            file = true,
                            folder = false,
                            folder_arrow = false,
                            git = true,
                        },
                        glyphs = {
                            git = {
                                unstaged = "×",
                                staged = "",
                                unmerged = "󰧾",
                                untracked = "",
                                renamed = "",
                                deleted = "",
                                ignored = "∅"
                            }
                        },
                        web_devicons = {
                            file = {
                                
                            },
                        },
                    },
                    indent_markers = {
                        enable = true,
                    },
                },
                hijack_directories = { enable = false },
                git = {
                    enable = true,
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    show_on_open_dirs = false,
                },
                modified = {
                    enable = true,
                    show_on_open_dirs = true,
                },
                filters = {
                    enable = true,
                    git_ignored = true,
                },
                ui = {
                    confirm = {
                        default_yes = true,
                    },
                },
                log = {},
            }
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { 
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            { "\\", "<cmd>Oil<CR>", desc = "Oil reveal", silent = true }
            -- _     -- open cwd
            -- g.    -- toggle hidden
            -- gs    -- sort
            -- gx    -- open external
            -- <C-p> -- preview

        },
        lazy = false,
        opts = {
            default_file_explorer = false, -- don't open on startup
            view_options = {
                show_hidden = false,
            },
            win_options = {
                signcolumn = "yes:2", -- ensure space for Git status symbols
            }
        }
    },
    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "stevearc/oil.nvim" },
        event = "VimEnter",
        opts = {}
    },
    {
        "refractalize/oil-git-status.nvim",
        event = "VimEnter",
        config = true,
        opts = {
            symbols = {
                index = {
                    ["!"] = "", -- Ignored
                    ["?"] = "", -- Untracked
                    ["A"] = "✚", -- Added
                    ["C"] = "C", -- Copied
                    ["D"] = "✖", -- Deleted
                    ["M"] = "", -- Modified
                    ["R"] = "󰁕", -- Renamed
                    ["T"] = "T", -- Type changed 
                    ["U"] = "", -- Unmerged
                    [" "] = " ",
                },
                working_tree = {
                    ["!"] = "", -- Ignored
                    ["?"] = "", -- Untracked
                    ["A"] = "✚", -- Added
                    ["C"] = "C", -- Copied
                    ["D"] = "✖", -- Deleted
                    ["M"] = "", -- Modified
                    ["R"] = "󰁕", -- Renamed
                    ["T"] = "T", -- Type changed
                    ["U"] = "", -- Unmerged
                    [" "] = " ",
                }
            }
        }
    }
}

