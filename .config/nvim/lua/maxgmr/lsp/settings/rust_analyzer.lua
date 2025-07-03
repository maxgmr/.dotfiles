local opts = {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			diagnostics = {
				styleLints = {
					enable = true,
				},
			},
		},
	},
}
return opts
