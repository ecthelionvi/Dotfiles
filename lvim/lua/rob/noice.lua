-- |||||||||||||||||||||||||||||||||| Noice ||||||||||||||||||||||||||||||||||| --

local status_ok, noice = pcall(require, "noice")
if not status_ok then
  return
end

noice.setup {
  messages = {
    view = "popup",
    view_search = false,
  },
  lsp = {
    hover = {
      enabled = false,
    },
    progress = {
      enabled = false,
    },
    signature = {
      enabled = false,
      auto_open = { enabled = false },
    },
  },
  routes = {
    {
      filter = { event = "msg_show", find = "->" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Hop" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E35" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E21" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E353" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E486" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E149" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "after" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "fewer" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "before" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "yanked" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "search" },
      opts = { skip = true },
    },
    {
      filter = { event = "notify", find = "Register" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "written" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "harpoon" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "substitutions" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "No lines in buffer" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Not an editor command" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Already at oldest change" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Already at newest change" },
      opts = { skip = true },
    },
  },
  views = {
    popup = {
      backend = "popup",
      relative = "editor",
      close = {
        events = { "BufLeave" },
        keys = { "q" },
      },
      enter = true,
      border = {
        style = "rounded",
      },
      position = "50%",
      size = {
        width = "120",
        height = "20",
      },
      win_options = {
        winhighlight = { Normal = "NoicePopup", FloatBorder = "NoicePopupBorder" },
      },
    },
  },
  cmdline = {
    view = "cmdline",
    format = {
      lua = false,
      help = false,
      search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
      search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
    },
  },
}
