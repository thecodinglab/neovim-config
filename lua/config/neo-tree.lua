local os = vim.loop.os_uname()

local open_cmd = 'xdg-open'
if os.sysname == 'Darwin' then
  open_cmd = 'open'
end

return {
  close_if_last_window = true,
  open_files_do_not_replace_types = { "terminal", "trouble" },
  window = {
    width = 50,
  },
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
    },
  },
  filesystem = {
    window = {
      mappings = {
        ["go"] = function(state)
          local node = state.tree:get_node()
          io.popen("/usr/bin/env '" .. open_cmd .. "' '" .. node.path .. "'")
        end,
        ["<leader>go"] = function(state)
          local Input = require('nui.input')
          local event = require("nui.utils.autocmd").event

          local input = Input({
            relative = "cursor",
            highlight = "Normal:Normal",
            border = {
              style = "rounded",
              text = {
                top = "Open with",
                top_align = "left"
              },
            },
            position = {
              row = 1,
              col = 0,
            },
            size = {
              width = 25,
              height = 1,
            },
          }, {
            prompt = '> ',
            on_submit = function(text)
              local node = state.tree:get_node()
              if node then
                io.popen("/usr/bin/env '" .. text .. "' '" .. node.path .. "'")
              end
            end,
          })

          input:map("n", "<esc>", input.input_props.on_close, { noremap = true })
          input:on(event.BufLeave, input.input_props.on_close, { once = true })

          input:mount()
        end,
      },
    },
  },
}
