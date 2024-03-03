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
        "uga-rosa/ccc.nvim",
        -- v0.7
        --commit = "392ef0640b96684e88b3965f32f3bc42530f66c3",
    },
    "neovim/nvim-lspconfig",
    "nvimdev/lspsaga.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvimtools/none-ls.nvim",
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-null-ls.nvim",
}
require("lazy").setup(plugins, {
    root = root .. "/plugins",
    concurrency = 1,
    git = {
        timeout = 300,
    },
})

vim.cmd.colorscheme("tokyonight")
-- add anything else here
vim.opt.ambiwidth = "double"

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lspconfig = require("lspconfig")
local mason_null_ls = require("mason-null-ls")
local null_ls = require("null-ls")
local ccc = require("ccc")
local lspsaga = require("lspsaga")

local lsp_servers = {
    -- OK Lsp
    "lua_ls",
    "marksman",
    "efm",
    "jsonls",
    -- NG? Lsp
    "typos_lsp",
    -- Not tested Lsp
    "bashls",
    "clangd",
    "csharp_ls",
    "neocmake",
    "cssls",
    "denols",
    "dockerls",
    "docker_compose_language_service",
    "eslint",
    "gopls",
    "graphql",
    "html",
    "tsserver",
    "jqls",
    "luau_lsp",
    "powershell_es",
    "pyright",
    "solargraph",
    "rust_analyzer",
    "esbonio",
    "taplo",
    "vimls",
    "yamlls",
    "zls",
}

local null_ls_sources = {
    -- Code Actions
    null_ls.builtins.code_actions.gitsigns,
    -- Completion
    -- Diagnostics
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.textlint,
    null_ls.builtins.diagnostics.yamllint,
    -- Formatting
    null_ls.builtins.formatting.just,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.textlint,
    -- Hover
}

---@param names string[]
---@return string[]
local function get_plugin_paths(names)
    local plug_ins = require("lazy.core.config").plugins
    local paths = {}
    for _, name in ipairs(names) do
        if plug_ins[name] then
            table.insert(paths, plug_ins[name].dir .. "/lua")
        else
            vim.notify("Invalid plugin name" .. name)
        end
    end
    return paths
end

---@param plug_ins string[]
---@return string[]
local function library(plug_ins)
    local paths = get_plugin_paths(plug_ins)
    table.insert(paths, vim.fn.stdpath("config") .. "/lua")
    table.insert(paths, vim.env.VIMRUNTIME .. "/lua")
    table.insert(paths, "${3rd}/luv/library")
    table.insert(paths, "${3rd}/busted/library")
    table.insert(paths, "${3rd}/luassert/library")
    return paths
end

local handlers = {
    function(server_name)
        nvim_lspconfig[server_name].setup({})
    end,

    ["lua_ls"] = function()
        nvim_lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    --diagnostics = {},
                    format = {
                        -- Use stylua
                        enable = false,
                    },
                    runtime = {
                        version = "LuaJIT",
                        pathStrict = true,
                        path = { "?.lua", "?/init.lua" },
                    },
                    semantic = {
                        enable = false,
                    },
                    workspace = {
                        checkThirdParty = "Disable",
                        library = library({ "lazy.nvim" }),
                    },
                },
            },
        })
    end,
}

ccc.setup({
    highlighter = {
        auto_enable = true,
        lsp = true,
    },
})

lspsaga.setup({})

mason.setup({
    max_concurrent_installers = 1,
})

mason_lspconfig.setup({
    ensure_installed = lsp_servers,
    handlers = handlers,
})

null_ls.setup({ sources = null_ls_sources })
mason_null_ls.setup({
    handlers = {},
})
