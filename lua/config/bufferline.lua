return {
  options = {
    mode = 'buffers',

    show_buffer_close_icons = false,
    always_show_bufferline = true,

    hover = {
      enabled = false,
    },

    offsets = {
      {
        filetype = 'neo-tree',
        text = vim.fn.getcwd,
        highlight = 'Directory',
      },
    },

    sort_by = 'directory',
  }
}
