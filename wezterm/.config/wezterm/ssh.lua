return function(config)
	config.ssh_domains = {
		{
			name = "roodnoot", -- A friendly name for your server
			remote_address = "roodnoot",
			username = "oheide",
			-- Optional: Add any specific SSH options here
			-- ssh_option = { User = 'your_username' },
			remote_wezterm_path = "/home/oheide/.local/bin/squashfs-root/usr/bin/wezterm",
		},
	}
end
