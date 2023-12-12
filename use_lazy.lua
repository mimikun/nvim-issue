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
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-emoji",
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

local need_lsp_servers = {
    -- typos
    "typos_lsp",
    -- bash
    "bashls",
    -- C, C++
    "clangd",
    -- C Sharp
    "csharp_ls",
    -- CMake
    "neocmake",
    -- CSS
    "cssls",
    -- deno
    "denols",
    -- Docker
    "dockerls",
    -- docker-compose
    "docker_compose_language_service",
    -- EFM (general purpose server)
    "efm",
    -- eslint
    "eslint",
    -- golang
    "gopls",
    -- GraphQL
    "graphql",
    -- HTML
    "html",
    -- JSON
    "jsonls",
    -- JavaScript, TypeScript
    "tsserver",
    -- jq
    "jqls",
    -- Lua
    "lua_ls",
    -- Luau
    "luau_lsp",
    -- Make
    --"autotools-language-server",
    -- Markdown
    "marksman",
    -- Powershell
    "powershell_es",
    -- Python
    "pyright",
    -- Ruby
    "solargraph",
    -- Rust
    "rust_analyzer",
    -- SQL
    -- Sphinx
    "esbonio",
    -- TOML
    "taplo",
    -- VimL
    "vimls",
    -- YAML
    "yamlls",
    -- Zig
    "zls",
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})
-- mason config
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local handlers = {
    function(server_name)
        nvim_lspconfig[server_name].setup({
            capabilities = cmp_nvim_lsp.default_capabilities(),
        })
    end,
}

mason.setup({
    --max_concurrent_installers = 1,
    ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        width = 0.88,
        height = 0.8,
    },
})

mason_lspconfig.setup({
    ensure_installed = need_lsp_servers,
    handlers = handlers,
})

local cmp = require("cmp")

local has_words_before = function()
    -- selene: allow(incorrect_standard_library_use)
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "emoji" },
    }),
})
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "path" },
    }),
})
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        {
            name = "buffer",
            option = {
                keyword_pattern = [[\k\+]],
            },
        },
    }),
})
