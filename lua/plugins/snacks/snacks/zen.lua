return function(opts)
    local enabled = opts and opts.enabled or false
    if not enabled then
        return { enabled = false }
    end

    return {
        enabled = true,
        toggles = {
            dim = true,
            git_signs = true,
            diagnostics = true,
            inlay_hints = true,
        },
        show = {
            statusline = false,
            tabline = false,
        },
        win = { style = "zen" },
        zoom = {
            toggles = {},
            show = { statusline = true, tabline = true },
            win = {
                backdrop = false,
                width = 0, -- full width
            },
        },
    }
end
