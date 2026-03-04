local opts = {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				features = "all",
			},
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
