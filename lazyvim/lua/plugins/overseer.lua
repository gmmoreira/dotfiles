return {
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Open Overseer Run" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer tasks window" },
    },
    config = true, -- doesnt pass opts table to setup function
  },
}
