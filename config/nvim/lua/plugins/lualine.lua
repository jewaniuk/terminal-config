-- ~/.config/nvim/lua/plugins/lualine.lua

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- 1. Extract your exact Horizon colors
            local colors = {
                bg       = "NONE",     -- Transparent to let your desktop wallpaper show through
                dark     = "#1c1e26",  -- Base dark color for high-contrast text over colored blocks
                fg       = "#d5d8da",
                grey     = "#6c6f93", 
                cyan     = "#26bbd9",  -- Normal Mode
                green    = "#29d398",  -- Insert Mode
                purple   = "#B877DB",  -- Visual Mode
                orange   = "#fab795",  -- Command Mode
                red      = "#e95678",  -- Replace Mode / Macros
            }

            -- 2. Map those colors to Lualine's modes
            local horizon_theme = {
                normal = {
                    a = { bg = colors.cyan, fg = colors.dark, gui = 'bold' },
                    b = { bg = colors.grey, fg = colors.dark },
                    c = { bg = colors.bg, fg = colors.fg },
                },
                insert = {
                    a = { bg = colors.green, fg = colors.dark, gui = 'bold' },
                },
                visual = {
                    a = { bg = colors.purple, fg = colors.dark, gui = 'bold' },
                },
                command = {
                    a = { bg = colors.orange, fg = colors.dark, gui = 'bold' },
                },
                replace = {
                    a = { bg = colors.red, fg = colors.dark, gui = 'bold' },
                },
                inactive = {
                    a = { bg = colors.bg, fg = colors.grey },
                    b = { bg = colors.bg, fg = colors.grey },
                    c = { bg = colors.bg, fg = colors.grey },
                }
            }

            -- 3. Custom Function: Active LSP Server
            local function lsp_name()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if next(clients) == nil then return 'No LSP' end
                local names = {}
                for _, client in ipairs(clients) do
                    table.insert(names, client.name)
                end
                return ' ' .. table.concat(names, ', ')
            end

            -- 4. Custom Function: Conditional Markdown Word Count
            local function markdown_word_count()
                if vim.bo.filetype == "markdown" then
                    return tostring(vim.fn.wordcount().words) .. " words"
                end
                return ""
            end

            -- 5. Custom Function: Macro Recording Status
            -- local function macro_recording()
            --     local reg = vim.fn.reg_recording()
            --     if reg ~= "" then
            --         return "● REC @" .. reg
            --     end
            --     return ""
            -- end

            -- 6. Custom Function: Python Virtual Environment
            local function python_venv()
                -- Only show on Python files
                if vim.bo.filetype ~= "python" then return "" end

                -- Check for standard venv or conda env
                local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV")
                if venv then
                    -- Extract just the folder name of the environment (e.g., "my_env")
                    return " " .. vim.fn.fnamemodify(venv, ":t")
                end
                return ""
            end

            -- 7. Custom Function: Indentation Status
            local function indent_status()
                local is_spaces = vim.bo.expandtab
                local spaces = vim.bo.shiftwidth
                return (is_spaces and "Spaces: " or "Tabs: ") .. spaces
            end

            -- 8. Custom Function: Clock
            local function clock()
                return " " .. os.date("%I:%M %p"):gsub("^0", "")
            end

            -- 9. Apply Configuration
            require("lualine").setup({
                options = {
                    theme = horizon_theme,
                    component_separators = '|',
                    section_separators = '',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },

                    -- The newly customized right side
                    lualine_x = {
                        python_venv,
                        lsp_name,
                        indent_status,
                        { markdown_word_count, color = { fg = colors.fg } }
                    },
                    lualine_y = { 'filetype' },
                    lualine_z = {clock}
                },
            })
        end
    }
}
