return function(opts)
  local enabled = opts and opts.enabled or false
  if not enabled then
    return { enabled = false }
  end

  local refs = { "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }

  local function set_refs()
    for _, hl in ipairs(refs) do
      vim.api.nvim_set_hl(0, hl, { underline = true })
    end
  end

  -- Apply immediately
  set_refs()

  -- Re-apply after colorscheme changes
  local group = vim.api.nvim_create_augroup("snacks_words_hl", { clear = true })
  vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
    group = group,
    callback = set_refs,
  })

  return { enabled = true }
end