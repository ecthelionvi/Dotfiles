-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Hide-Filetype
autocmd("FileType", {
  group = augroup("hide-filetype", { clear = true }),
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").hide_filetype() end)
    end)
  end,
})

-- Close-Nvim-Tree
autocmd("BufDelete", {
  group = augroup("nvim-tree", { clear = true }),
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").close_nvim_tree() end)
    end)
  end,
})

-- Quit-Nvim-Tree
autocmd({ "QuitPre" }, {
  group = "nvim-tree",
  callback = function()
    pcall(function() vim.cmd("NvimTreeClose") end)
    pcall(function() require("rob.utils").close_all_hidden() end)
  end
})

-- Change-Directory .. Special-Keymaps
autocmd({ "BufNew", "BufWinEnter" }, {
  group = augroup("miscellaneous", { clear = true }),
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").cwd_set_options() end)
      pcall(function() require("rob.utils").special_keymaps() end)
    end)
  end,
})

-- Python-Fstring
vim.api.nvim_create_augroup("py-fstring", { clear = true })
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = { "*.py" },
  group = "py-fstring",
  callback = function(opts)
    -- Only run if f-string escape character is typed
    if vim.v.char ~= "{" then return end

    -- Get node and return early if not in a string
    local node = vim.treesitter.get_node()

    if not node then return end
    if node:type() ~= "string" then node = node:parent() end
    if not node or node:type() ~= "string" then return end

    local row, col, _, _ = vim.treesitter.get_node_range(node)

    -- Return early if string is already a format string
    local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col - 1, row, col, {})[1]
    if first_char == "f" then return end

    -- Move cursor to before the opening quote and insert 'f'
    vim.api.nvim_input("<Esc>")
    vim.api.nvim_input(string.format("%sG", row + 1)) -- move to row
    vim.api.nvim_input(string.format("%s|", col))     -- move to col
    vim.api.nvim_input("hi")                          -- move one position left and enter insert mode
    vim.api.nvim_input("f")                           -- insert 'f'
    vim.api.nvim_input("<Esc>")
    vim.api.nvim_input('f{a')                         -- escape back to normal mode
  end,
})

return M
