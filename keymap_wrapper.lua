-- keymap_wrapper.lua

-- Define the modes table
modes = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  operator_pending_mode = "o"
}

-- Define the keymaps table
keymaps = {
  -- Define a table for each mode
  [modes.insert_mode] = {
    ["<C-a>"] = {
      cmd = "move to beginning of line",
      opts = {expr = true, noremap = true}
    },
    ["<C-e>"] = {
      cmd = "move to end of line",
      opts = {expr = true, noremap = true}
    }
  },
  [modes.normal_mode] = {
    ["dd"] = {
      cmd = "delete current line",
      opts = {noremap = true}
    },
    ["yy"] = {
      cmd = "yank current line",
      opts = {noremap = true}
    }
  },
  [modes.term_mode] = {
    ["<C-c>"] = {
      cmd = "interrupt current command",
      opts = {noremap = true}
    },
    ["<C-z>"] = {
      cmd = "suspend current command",
      opts = {noremap = true}
    }
  },
  [modes.visual_mode] = {
    ["v"] = {
      cmd = "exit visual mode",
      opts = {noremap = true}
    },
    ["V"] = {
      cmd = "enter visual line mode",
      opts = {noremap = true}
    }
  },
  [modes.visual_block_mode] = {
    ["<C-v>"] = {
      cmd = "exit visual block mode",
      opts = {noremap = true}
    },
    ["<C-q>"] = {
      cmd = "enter visual block mode",
      opts = {noremap = true}
    }
  },
  [modes.command_mode] = {
    [":"] = {
      cmd = "enter command-line mode",
      opts = {noremap = true}
    },
    ["/"] = {
      cmd = "search forward",
      opts = {noremap = true}
    }
  },
  [modes.operator_pending_mode] = {
    ["d"] = {
      cmd = "delete",
      opts = {noremap = true}
    },
    ["y"] = {
      cmd = "yank",
      opts = {noremap = true}
    }
  }
}

function M.set_keymaps(mode, key, val)
  if type(val) == "table" then
    opt = val.opts
    val = val.cmd
  end
  if val then
    vim.api.nvim_set_keymap(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

function set_keymaps(keymaps)
  for mode, mappings in pairs(keymaps) do
    for mapping, data in pairs(mappings) do
      M.set_keymaps(mode, mapping, data)
    end
  end
end

function set_keymaps_wrapper()
  set_keymaps(keymaps)
end

return {set_keymaps_wrapper = set_keymaps_wrapper}

-- config.lua
local keymaps = require("path.to.keymap_wrapper")
keymaps.set_keymaps_wrapper()
