local status_ok, noice = pcall(require, "noice")
if not status_ok then
  return
end

-- Noice
vim.api.nvim_create_autocmd("filetype", {
  pattern = "noice",
  callback = function()
    local bufnr = vim.fn.bufnr("%")
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<esc>",
      "q",
      { silent = true }
    )
  end
})

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
      filter = { event = "msg_show", find = "Hop" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "->" },
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
      filter = { event = "msg_show", find = "search" },
      opts = { skip = true },
    },
    {
      filter = { event = "notify", find = "Register" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "harpoon" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "AutoSave" },
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
      filter = { event = "msg_show", find = "Already at oldest change" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Already at newest change" },
      opts = { skip = true },
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
