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
    "nvim-treesitter/nvim-treesitter",
    "IndianBoy42/tree-sitter-just",
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

-- nvim-treesitter
local need_parsers = {
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "graphql",
    "html",
    "ini",
    "java",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "kdl",
    "latex",
    "lua",
    "luadoc",
    "luap",
    "luau",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "nix",
    "ocaml",
    "ocaml_interface",
    "python",
    "regex",
    "rst",
    "ruby",
    "rust",
    "scala",
    "scss",
    "sql",
    "svelte",
    "swift",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "yaml",
    "zig",
}

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = {},
    },
    ensure_installed = need_parsers,
})
