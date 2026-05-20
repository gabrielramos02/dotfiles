return {
    -- lazy.nvim
    {
        "folke/snacks.nvim",
        enabled = false,
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            explorer = {
                enabled = true,
                replace_netrw = true, -- Replace netrw with the snacks explorer
                trash = true,         -- Use the system trash when deleting files
            },
            picker = {
                sources = {
                    explorer = {
                        autoclose = true
                        -- your explorer picker configuration comes here
                        -- or leave it empty to use the default settings
                    }
                }
            }
        },
        keys = {
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        }
    }
}
