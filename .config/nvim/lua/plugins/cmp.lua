return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			return {
				completion = { completeopt = "menu,menuone,noinsert" },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if require("copilot.suggestion").is_visible() then
							require("copilot.suggestion").accept()
						elseif cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
						elseif luasnip.expandable() then
							luasnip.expand()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				}),
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						scrollbar = true,
						scrolloff = 6,
						col_offset = -2,
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						col_offset = -1,
						side_padding = 0,
						scrollbar = false,
					}),
				},
				formatting = {
					fields = { "abbr", "menu", "kind" },

					format = function(entry, item)
						local n = entry.source.name

						if n == "nvim_lsp" then
							item.menu = "[LSP]"
						elseif n == "nvim_lua" then
							item.menu = "[nvim]"
						else
							item.menu = string.format("[%s]", n)
						end

						return item
					end,
				},
			}
		end,
		config = function(_, opts)
			for _, source in ipairs(opts.sources) do
				source.group_index = source.group_index or 1
			end
			require("cmp").setup(opts)
		end,
	},
}
