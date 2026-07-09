return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function ()
            -- install language support
            -- require('nvim-treesitter').install({ 'arduino', 'c', 'cmake', 'cpp', 'css', 'devicetree', 'dockerfile', 'fsh', 'gitattributes', 'gitignore', 'helm', 'http', 'hurl', 'java', 'jq', 'json', 'kconfig', 'kotlin', 'latex', 'lua', 'markdown', 'python', 'regex', 'rust', 'sql', 'ssh_config', 'terraform', 'toml', 'vim', 'yaml'}):wait(300000) -- wait max. 5 minutes
            require('nvim-treesitter').install({ 
                'arduino',
                -- 'c',
                -- 'cmake',
                -- 'cpp',
                -- 'css',
                -- 'devicetree',
                -- 'dockerfile',
                -- 'fsh',
                -- 'gitattributes',
                -- 'gitignore',
                -- 'helm',
                -- 'http',
                -- 'hurl',
                -- 'java',
                -- 'jq',
                'json',
                -- 'kconfig',
                -- 'kotlin',
                -- 'latex',
                -- 'lua',
                -- 'markdown',
                -- 'python',
                -- 'regex',
                'rust',
                -- 'sql',
                -- 'ssh_config',
                -- 'terraform',
                -- 'toml',
                -- 'vim',
                -- 'yaml'
            }):wait(300000) -- wait max. 5 minutes
        end
    }
}
