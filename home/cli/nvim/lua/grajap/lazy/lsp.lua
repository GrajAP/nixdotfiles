return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        'simrat39/rust-tools.nvim',
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        require("lspconfig").tsserver.setup({
            on_attach = on_attach,
            capabilities = capabilities
        })
        require("fidget").setup({})
        require("mason").setup()
        require("lspconfig").nixd.setup({
            cmd = { "nixd" },
            settings = {
                nixd = {
                    nixpkgs = {
                        expr = "import <nixpkgs> { }",
                    },
                    formatting = {
                        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
                    },
                    options = {
                        nixos = {
                            expr = '(builtins.getFlake "/etc/nixos/").nixosConfigurations.grajap.options',
                        },
                        home_manager = {
                            expr = '(builtins.getFlake "/etc/nixos/").homeConfigurations.grajap.options',
                        },
                    },
                },
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "tsserver",
                "html",
                "cssls",
                "lua_ls",
                "rust_analyzer",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            }),
            formatting = {
                fields = { 'menu', 'abbr', 'kind' },
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        vsnip = '⋗',
                        buffer = 'Ω',
                        path = '🖫',
                    }
                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
