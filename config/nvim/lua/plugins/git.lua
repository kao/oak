return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = " <date> • <author> • <summary> • <<sha>>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
      gitblame_schedule_event = "CursorHold",
      gitblame_clear_event = "CursorHoldI",
    },
    keys = {
      { "<leader>go", "<cmd>GitBlameOpenFileURL<cr>", desc = "Open file on Github" },
    },
  },
}
