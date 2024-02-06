local workspaces = {
  {
    name = "knowledgebase",
    path = "~/vaults/knowledgebase",
  },
}

local events = {}
for i, workspace in pairs(workspaces) do
  local dir = vim.fn.expand(workspace.path)
  events[2*i+0] = 'BufReadPre ' .. dir .. '**.md'
  events[2*i+1] = 'BufNewFile ' .. dir .. '**.md'
end

return {
  'epwalsh/obsidian.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },

  -- from https://github.com/epwalsh/obsidian.nvim/blob/86caccdac82e78a268e25fab901f47bc36ccd33c/lua/obsidian/commands/init.lua#L6-L21
  cmd = { 
    'ObsidianCheck',
    'ObsidianToday',
    'ObsidianYesterday',
    'ObsidianTomorrow',
    'ObsidianNew',
    'ObsidianOpen',
    'ObsidianBacklinks',
    'ObsidianSearch',
    'ObsidianTemplate',
    'ObsidianQuickSwitch',
    'ObsidianLinkNew',
    'ObsidianLink',
    'ObsidianFollowLink',
    'ObsidianWorkspace',
    'ObsidianRename',
    'ObsidianPasteImg',
  },
  keys = {
    { '<leader>nn', '<cmd>ObsidianQuickSwitch<cr>' },
    { '<leader>fn', '<cmd>ObsidianSearch<cr>' },
  },
  events = events,

  opts = {
    workspaces = workspaces,

    notes_subdir = "notes",
    daily_notes = {
      folder = "notes/dailies",
      date_format = "%Y-%m-%d",
    },

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    follow_url_func = function(url)
      if vim.fn.executable('xdg-open') then
        vim.fn.jobstart({'xdg-open', url})
        return
      end

      if vim.fn.executable('open') then
        vim.fn.jobstart({'open', url})
        return
      end

      vim.notify('unable to open link: no tool found', vim.log.levels.ERROR)
    end,
  },
}
