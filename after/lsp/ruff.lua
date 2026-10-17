-- ┌──────────────────┐
-- │ ruff LSP config  │
-- └──────────────────┘
--
-- This file contains configuration of 'ruff' language server.
-- Source: https://docs.astral.sh/ruff/editors/
--
-- It provides lint diagnostics and code actions (fix all, organize imports).
-- Without project config it uses Ruff's default rules.
return {
  on_attach = function(client)
    -- Prefer hover from 'basedpyright'
    client.server_capabilities.hoverProvider = false
  end,
}
