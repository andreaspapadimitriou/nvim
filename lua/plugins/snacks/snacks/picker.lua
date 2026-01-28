return function(opts)
    return {
        enabled = opts.enabled or false,
        previewers = {
            diff = {
                cmd = { "delta" },
            },
        },
        formatters = {
            file = {
                filename_first = true,
                truncate = 40,
            },
        },
    }
end
