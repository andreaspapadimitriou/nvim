-- Autosave implementation with debounce
local autosave_timer = nil
local autosave_debounce_ms = 10000
vim.g.autosave_enabled = true -- Global toggle for autosave

-- Filetypes to skip autosave
local autosave_skip_filetypes = {
    gitcommit = true,
    gitrebase = true,
    hgcommit = true,
}

local function autosave(bufnr)
    -- Skip if autosave is disabled
    if not vim.g.autosave_enabled then
        return
    end

    -- Skip if buffer is not valid
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    -- Skip certain filetypes
    local ft = vim.bo[bufnr].filetype
    if autosave_skip_filetypes[ft] then
        return
    end

    -- Only save normal buffers that are modified and have a name
    if
        vim.bo[bufnr].modified
        and vim.fn.bufname(bufnr) ~= ""
        and vim.bo[bufnr].buftype == ""
        and vim.bo[bufnr].modifiable
    then
        -- Use pcall to prevent errors from breaking the statusline
        local ok, err = pcall(vim.cmd, "silent! write")
        if not ok then
            vim.notify("Autosave failed: " .. tostring(err), vim.log.levels.WARN)
        end
    end
end

-- Immediate save on BufLeave or FocusLost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    pattern = "*",
    callback = function(args)
        autosave(args.buf)
    end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        -- Cancel existing timer if any
        if autosave_timer then
            autosave_timer:stop()
            autosave_timer = nil
        end
    end,
})

-- Deferred save for InsertLeave and TextChanged (covers undo, paste, etc.)
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    callback = function(args)
        -- Cancel existing timer if any
        if autosave_timer then
            autosave_timer:stop()
            autosave_timer = nil
        end

        -- Create new debounced timer
        autosave_timer = vim.defer_fn(function()
            autosave(args.buf)
            autosave_timer = nil
        end, autosave_debounce_ms)
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    callback = function()
        -- Save all modified buffers on exit
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if
                vim.api.nvim_buf_is_valid(bufnr)
                and vim.bo[bufnr].buflisted
                and vim.bo[bufnr].bufhidden == ""
            then
                autosave(bufnr)
            end
        end
    end,
})

-- Toggle autosave keymap
vim.keymap.set("n", "<leader>wab", function()
    vim.g.autosave_enabled = not vim.g.autosave_enabled
    local status = vim.g.autosave_enabled and "enabled" or "disabled"
    vim.notify("Autosave " .. status, vim.log.levels.INFO)
end, { desc = "Toggle buffer autosave" })

