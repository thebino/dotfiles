return {
    {
        'akinsho/toggleterm.nvim', 
        version = "*", 
        lazy = false,
        config = function()
            function _mersge_toggle()
                local term = require("toggleterm.terminal").Terminal
                local mersge = term:new({ direction = "float", cmd = "mersge .", hidden = true })

                mersge:toggle()
            end
            vim.api.nvim_set_keymap("n", "<leader>gm", "<cmd>lua _mersge_toggle()<CR>", {noremap = true, silent = true})

            function _jwtui_toggle()
                -- all lines in the current buffer
                local lines = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '')

                local term = require("toggleterm.terminal").Terminal
                local jwtui = term:new({ direction = "float", cmd = "jwtui --tick-rate 900 " .. lines, hidden = true })

                jwtui:toggle()
            end

            vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>lua _jwtui_toggle()<CR>", {noremap = true, silent = true})
        end,
    }
}
