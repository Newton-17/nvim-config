local on_attach_ruff = function(client, bufnr)
  if client.name == "ruff_lsp" then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local nvim_lsp = require "lspconfig"
    local mason_lspconfig = require "mason-lspconfig"

    local protocol = require "vim.lsp.protocol"

    local on_attach = function(client, bufnr)
      -- format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format() end,
        })
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    mason_lspconfig.setup_handlers {
      function(server)
        nvim_lsp[server].setup {
          capabilities = capabilities,
        }
      end,
      ["cssls"] = function()
        nvim_lsp["cssls"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
      ["tailwindcss"] = function()
        nvim_lsp["tailwindcss"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
      ["html"] = function()
        nvim_lsp["html"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
      ["jsonls"] = function()
        nvim_lsp["jsonls"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
      ["eslint"] = function()
        nvim_lsp["eslint"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
      ["pyright"] = function()
        nvim_lsp["pyright"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
              },
            },
          },
        }
      end,
      ["gopls"] = function()
        nvim_lsp["gopls"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
      ["templ"] = function()
        nvim_lsp["templ"].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
    }
  end,
}
