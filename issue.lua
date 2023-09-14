for name, url in pairs{
  -- ADD PLUGINS _NECESSARY_ TO REPRODUCE THE ISSUE, e.g:
  -- some_plugin = 'https://github.com/author/plugin.nvim'
  fzf_lua = 'https://github.com/ibhagwan/fzf-lua'
} do
  local install_path = vim.fn.fnamemodify('nvim-issue/'..name, ':p')
  if vim.fn.isdirectory(install_path) == 0 then
    vim.fn.system { 'git', 'clone', '--depth=1', url, install_path }
  end
  vim.opt.runtimepath:append(install_path)
end

-- ADD INIT.LUA SETTINGS THAT IS _NECESSARY_ FOR REPRODUCING THE ISSUE
require("fzf-lua").setup({})

vim.opt.ambiwidth = "double"
