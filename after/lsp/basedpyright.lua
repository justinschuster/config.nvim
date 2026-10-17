-- ┌──────────────────────────┐
-- │ basedpyright LSP config  │
-- └──────────────────────────┘
--
-- This file contains configuration of 'basedpyright' language server.
-- Source: https://github.com/DetachHead/basedpyright
--
-- Settings mirror VS Code's Pylance setup and apply when a project has no
-- pyright config of its own (`[tool.pyright]` or 'pyrightconfig.json'
-- override them). See https://docs.basedpyright.com/latest/configuration/
return {
  -- Use '.venv' closest to project root as interpreter. Searching upward
  -- supports both per-package and workspace-level virtual environments.
  -- Uses `on_init` to not override `on_attach` from 'nvim-lspconfig'.
  on_init = function(client)
    local find_opts = { upward = true, type = 'directory', path = client.root_dir, stop = vim.uv.os_homedir() }
    local venv = vim.fs.find('.venv', find_opts)[1]
    if venv == nil then return end

    client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, {
      pythonPath = venv .. '/bin/python',
    })
    client:notify('workspace/didChangeConfiguration', { settings = client.settings })
  end,
  settings = {
    basedpyright = {
      -- Let 'ruff' organize imports
      disableOrganizeImports = true,
      analysis = {
        -- Default 'recommended' mode is much stricter than Pylance's 'basic'
        typeCheckingMode = 'basic',
        diagnosticSeverityOverrides = {
          reportArgumentType = 'none',
          reportOptionalMemberAccess = 'none',
        },
      },
    },
  },
}
