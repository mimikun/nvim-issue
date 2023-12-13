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
    "adelarsq/image_preview.nvim",
    "airblade/vim-gitgutter",
    "alker0/chezmoi.vim",
    "Allianaab2m/penumbra.nvim",
    "aspeddro/pandoc.nvim",
    "barrett-ruth/live-server.nvim",
    "catppuccin/nvim",
    "cespare/vim-toml",
    "crusoexia/vim-monokai",
    "dinhhuy258/git.nvim",
    "dstein64/vim-startuptime",
    "EdenEast/nightfox.nvim",
    "ellisonleao/glow.nvim",
    "epwalsh/obsidian.nvim",
    "folke/noice.nvim",
    "folke/todo-comments.nvim",
    "folke/trouble.nvim",
    "folke/which-key.nvim",
    "github/copilot.vim",
    "glepnir/dashboard-nvim",
    "godlygeek/tabular",
    "goolord/alpha-nvim",
    "gpanders/editorconfig.nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "imsnif/kdl.vim",
    "IndianBoy42/tree-sitter-just",
    "is0n/jaq-nvim",
    "jghauser/mkdir.nvim",
    "j-hui/fidget.nvim",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "kihachi2000/yash.nvim",
    "kkharji/sqlite.lua",
    "kode-team/mastodon.nvim",
    "kylechui/nvim-surround",
    "kyoh86/momiji",
    "L3MON4D3/LuaSnip",
    "lambdalisue/fern-git-status.vim",
    "lambdalisue/fern-renderer-nerdfont.vim",
    "lambdalisue/fern.vim",
    "lambdalisue/gin.vim",
    "lambdalisue/glyph-palette.vim",
    "lambdalisue/kensaku-command.vim",
    "lambdalisue/kensaku-search.vim",
    "lambdalisue/kensaku.vim",
    "lambdalisue/nerdfont.vim",
    "lambdalisue/readablefold.vim",
    "lewis6991/gitsigns.nvim",
    "LhKipp/nvim-nu",
    "loctvl842/monokai-pro.nvim",
    "mattn/calendar-vim",
    "mimikun/vimdoc-ja",
    "monaqa/dial.nvim",
    "MunifTanjim/nui.nvim",
    "narutoxy/silicon.lua",
    "nastevens/vim-cargo-make",
    "nastevens/vim-duckscript",
    "neoclide/coc.nvim",
    "NeogitOrg/neogit",
    "neovim/nvim-lspconfig",
    "NoahTheDuke/vim-just",
    "numToStr/Comment.nvim",
    "nvim-lualine/lualine.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neo-tree/neo-tree.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "Omochice/dps-translate-vim",
    "poljar/typos.nvim",
    "preservim/vim-markdown",
    "projekt0n/github-nvim-theme",
    "rafamadriz/friendly-snippets",
    "rbtnn/vim-ambiwidth",
    "rcarriga/nvim-notify",
    "registerGen/clock.nvim",
    "ron-rs/ron.vim",
    "roobert/surround-ui.nvim",
    "saadparwaiz1/cmp_luasnip",
    "saecki/crates.nvim",
    "sainnhe/edge",
    "sainnhe/sonokai",
    "segeljakt/vim-silicon",
    "shaunsingh/nord.nvim",
    "sindrets/diffview.nvim",
    "skanehira/denops-docker.vim",
    "skanehira/denops-translate.vim",
    "startup-nvim/startup.nvim",
    "stevearc/dressing.nvim",
    "tanvirtin/monokai.nvim",
    "thinca/vim-quickrun",
    "thinca/vim-scouter",
    "tiagovla/tokyodark.nvim",
    "vim-denops/denops.vim",
    "vim-skk/skkeleton",
    "voidekh/kyotonight.vim",
    "Vonr/align.nvim",
    "willelz/skk-tutorial.vim",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "windwp/nvim-ts-autotag",
    "Xuyuanp/scrollbar.nvim",
    "yutkat/confirm-quit.nvim",
    "zaldih/themery.nvim",
    "zbirenbaum/copilot.lua",
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
