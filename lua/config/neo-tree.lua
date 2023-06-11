local status_ok, neo_tree = pcall(require, 'neo-tree')
if not status_ok then
  return
end

vim.g.neu_tree_remove_legacy_commands = 1

local os = vim.loop.os_uname()

local open_cmd = 'xdg-open'
if os.sysname == 'Darwin' then
  open_cmd = 'open'
end

neo_tree.setup({
  close_if_last_window = true,
  open_files_do_not_replace_types = { "terminal", "trouble" },
  window = {
    width = 50,
  },
  filesystem = {
    window = {
      mappings = {
        ["go"] = function(state)
          local node = state.tree:get_node()
          io.popen("/usr/bin/env '" .. open_cmd .. "' '" .. node.path .. "'")
        end,
      },
    },
  },
})
