return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>y",
            "<cmd>Yazi<cr>",
            desc = "yazi - current dir",
        },
        {
            "<leader>Y",
            "<cmd>Yazi cwd<cr>",
            desc = "yazi - root dir",
        },
        {
            "<c-up>",
            "<cmd>Yazi toggle<cr>",
            desc = "yazi - resume session",
        },
    },
    opts = {
        open_for_directories = true,
        keymaps = {
            show_help = "<f1>",
        },
    },
}
