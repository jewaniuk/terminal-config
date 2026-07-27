local M = {}

function M.setup()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.background = "dark"
    vim.g.colors_name = "ghostty_horizon"

    local hl = vim.api.nvim_set_hl

    local c = {
        bg = "#1c1e26", fg = "#d5d8da", selection = "#6c6f93",
        cursor = "#e5e5e5", keyword = "#ee64ac", func = "#29d398",
        string = "#fab795", type = "#B877DB", num = "#26bbd9",
        text_var_op = "#e5e5e5", comment = "#6c6f93",
        error = "#e95678", warning = "#fab795",
    }

    -- 1. Base Editor UI
    hl(0, "Normal", { fg = c.fg, bg = "NONE" })
    hl(0, "SignColumn", { bg = "NONE" })
    hl(0, "LineNr", { fg = c.comment, bg = "NONE" })
    hl(0, "CursorLineNr", { fg = c.text_var_op, bold = true })
    hl(0, "EndOfBuffer", { bg = "NONE" })
    hl(0, "NormalFloat", { bg = "NONE" })
    hl(0, "Visual", { bg = c.selection })
    hl(0, "WinSeparator", { fg = c.comment })
    hl(0, "Cursor", { bg = c.cursor, fg = c.bg })
    hl(0, "TermCursor", { bg = c.cursor, fg = c.bg })
    hl(0, "ModeMsg", { fg = c.text_var_op, bold = true })

    -- 2. Treesitter Keywords
    hl(0, "@keyword", { fg = c.keyword })
    hl(0, "@keyword.return", { fg = c.keyword })
    hl(0, "@keyword.import", { fg = c.keyword })
    hl(0, "@keyword.function", { fg = c.keyword })
    hl(0, "@keyword.repeat", { fg = c.keyword })
    hl(0, "@keyword.conditional", { fg = c.keyword })

    -- 3. Functions, Methods, and Constructors
    hl(0, "@function", { fg = c.func, italic = false })
    hl(0, "@function.call", { fg = c.func, italic = false })
    hl(0, "@function.builtin", { fg = c.func, italic = false })
    hl(0, "@function.method", { fg = c.func, italic = false })
    hl(0, "@function.method.call", { fg = c.func, italic = false })
    hl(0, "@constructor", { fg = c.func, italic = false })

    -- 4. Strings
    hl(0, "@string", { fg = c.string })
    hl(0, "@character", { fg = c.string })

    -- 5. Types
    hl(0, "@type", { fg = c.type, italic = false })
    hl(0, "@type.builtin", { fg = c.type, italic = true })

    -- 6. Numbers
    hl(0, "@number", { fg = c.num })
    hl(0, "@number.float", { fg = c.num })

    -- 7. Variables & Operators
    hl(0, "@variable", { fg = c.text_var_op })
    hl(0, "@variable.parameter", { fg = c.text_var_op })
    hl(0, "@variable.builtin", { fg = c.type, italic = true })
    hl(0, "@variable.member", { fg = c.text_var_op })
    hl(0, "@property", { fg = c.text_var_op })
    hl(0, "@field", { fg = c.text_var_op })
    hl(0, "@module", { fg = c.text_var_op })
    hl(0, "@namespace", { fg = c.text_var_op })
    hl(0, "@operator", { fg = c.text_var_op })

    -- 8. Comments, Booleans, and Attributes
    hl(0, "@comment", { fg = c.comment, italic = true })
    hl(0, "@string.documentation", { fg = c.comment, italic = true })
    hl(0, "@boolean", { fg = c.keyword })
    hl(0, "@constant.builtin", { fg = c.keyword })
    hl(0, "@attribute", { fg = c.func })

    -- 9. Punctuation
    hl(0, "@punctuation.bracket", { fg = c.text_var_op })
    hl(0, "@punctuation.delimiter", { fg = c.text_var_op })
    hl(0, "@punctuation.special", { fg = c.text_var_op })

    -- 10. Diagnostics
    hl(0, "DiagnosticError", { fg = c.error })
    hl(0, "DiagnosticWarn", { fg = c.warning })
    hl(0, "DiagnosticHint", { fg = c.num })
    hl(0, "DiagnosticInfo", { fg = c.num })

    hl(0, "DiagnosticUnderlineError", { sp = c.error, undercurl = true })
    hl(0, "DiagnosticUnderlineWarn", { sp = c.warning, undercurl = true })
    hl(0, "DiagnosticUnderlineHint", { sp = c.num, undercurl = true })
    hl(0, "DiagnosticUnderlineInfo", { sp = c.num, undercurl = true })
    hl(0, "DiagnosticUnnecessary", { fg = c.comment, sp = c.num, undercurl = true })

    -- 11. Markdown
    hl(0, "@markup.heading.1", { fg = c.keyword, bold = true }) -- Pink
    hl(0, "@markup.heading.2", { fg = c.func, bold = true })    -- Green
    hl(0, "@markup.heading.3", { fg = c.string, bold = true })  -- Orange
    hl(0, "@markup.heading.4", { fg = c.type, bold = true })    -- Purple
    hl(0, "@markup.heading.5", { fg = c.num, bold = true })     -- Cyan
    hl(0, "@markup.heading.6", { fg = c.fg, bold = true })      -- Default text color

    hl(0, "@markup.list", { fg = c.num })      -- Cyan bullet points
    hl(0, "@markup.raw", { fg = c.comment })   -- Greyed out inline code (`code`)
    hl(0, "@markup.link", { fg = c.func })     -- Green hyperlinks
end

return M
