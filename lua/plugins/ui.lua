return {
  -- Better `vim.notify()`
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss All Notifications',
      },
    },
    opts = {
      stages = 'static',
      timeout = 6000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      --    if not LazyVim.has 'noice.nvim' then
      --    LazyVim.on_very_lazy(function()
      vim.notify = require 'notify'
      --  end)
      --end
    end,
  },
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
     -- stylua: ignore
     keys = {
       { "<leader>sn", "", desc = "+noice"},
       { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
       { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
       { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
       { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
       { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
       { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
       { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
       { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
     },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
    end,
  },
  {
   'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',  
    event = "VeryLazy",
    keys = {
      { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
      { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
      { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
      { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
      { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
      { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
      { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
      { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
      { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
      { "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Go to last buffer" },
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
      { "<leader>bn", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer to next position" },
      { "<leader>bN", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer to previous position" },
      },
    opts = {
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead of buffers
            numbers = "ordinal", -- "none" | "ordinal" | "buffer_id"
            buffer_close_icon = '󰅖',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true
                }
            },
            color_icons = true
      },
    },
  },
}


