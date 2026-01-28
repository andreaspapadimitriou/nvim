return function(opts)
    return {
        enabled = opts.enabled or false,
        keys = {
            q = "hide",
            gf = function(self)
                local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                if f == "" then
                    Snacks.notify.warn("No file under cursor")
                else
                    self:hide()
                    vim.schedule(function()
                        vim.cmd("e " .. f)
                    end)
                end
            end,
        },
    }
end
