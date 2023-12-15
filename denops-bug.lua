-- DO NOT change the paths and don't remove the colorscheme
local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
    vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
local plugins = {
    "folke/tokyonight.nvim",
    -- add any other plugins here
    {
        "skanehira/denops-translate.vim",
        lazy = false,
        dependencies = {
            "vim-denops/denops.vim",
        },
    },
}
require("lazy").setup(plugins, {
    root = root .. "/plugins",
    --concurrency = 1,
    git = {
        timeout = 300,
    },
})

vim.cmd.colorscheme("tokyonight")
-- add anything else here

-- I am Japanese.
vim.opt.ambiwidth = "double"

-- denops-translate
vim.g.translate_source = "en"
vim.g.translate_target = "ja"
vim.g.translate_border_chars = { "+", "-", "+", "|", "+", "-", "+", "|" }
