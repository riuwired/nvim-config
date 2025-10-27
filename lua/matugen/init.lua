local M = {}

-- Path to colors file - use HOME directory, NOT nix store
M.COLORS_PATH = vim.fn.expand("~/.cache/matugen/nvim-colors.lua")

function M.load_colors()
	if vim.fn.filereadable(M.COLORS_PATH) == 1 then
		local chunk, err = loadfile(M.COLORS_PATH)
		if chunk then
			local ok, colors = pcall(chunk)
			if ok and type(colors) == "table" then
				return colors
			end
		end
	end

	local ok, colors = pcall(require, "themes.matugen-colors")
	if ok then
		return colors
	end
	
	-- Last resort: default colors
	return {
		bg = "#1a1a1a",
		fg = "#e0e0e0",
		primary = "#80a0ff",
		surface = "#2a2a2a",
		outline = "#808080",
		red = "#ff6b6b",
		green = "#51cf66",
		yellow = "#ffd93d",
		blue = "#80a0ff",
		magenta = "#ff6bcd",
		cyan = "#6bffff",
	}
end

-- Generate derived colors
local function add_derived_colors(colors)
	local function lighten(hex, amount)
		hex = hex:gsub("#", "")
		local r = tonumber(hex:sub(1, 2), 16)
		local g = tonumber(hex:sub(3, 4), 16)
		local b = tonumber(hex:sub(5, 6), 16)

		local factor = amount / 100.0
		if factor > 0 then
			r = math.floor(r + (255 - r) * factor)
			g = math.floor(g + (255 - g) * factor)
			b = math.floor(b + (255 - b) * factor)
		else
			r = math.floor(r * (1 + factor))
			g = math.floor(g * (1 + factor))
			b = math.floor(b * (1 + factor))
		end

		return string.format("#%02x%02x%02x",
			math.max(0, math.min(255, r)),
			math.max(0, math.min(255, g)),
			math.max(0, math.min(255, b)))
	end
	
	colors.bg_light = lighten(colors.bg, 10)
	colors.bg_lighter = lighten(colors.bg, 20)
	colors.bg_dark = lighten(colors.bg, -10)
	colors.fg_dark = lighten(colors.fg, -20)
	colors.comment = colors.outline
	
	return colors
end

-- Apply all highlights
function M.apply()
	local colors = M.load_colors()
	colors = add_derived_colors(colors)
	
	-- Store globally
	_G.matugen_colors = colors
	
	-- Apply highlights
	local highlights = require("matugen.highlights")
	highlights.apply(colors)
	
	return colors
end

-- Reload everything
function M.reload()
	print("🔄 Reloading Matugen colors from " .. M.COLORS_PATH)
	
	local colors = M.apply()
	print("  ✓ Colors applied → Primary: " .. colors.primary)
	
	-- Reload plugin themes
	package.loaded["matugen.plugins"] = nil
	local plugin_themes_ok, plugin_themes = pcall(require, "matugen.plugins")
	
	if plugin_themes_ok then
		plugin_themes.setup_all()
		print("  ✓ Plugin themes applied")
	end
	
	-- Trigger ColorScheme autocmd
	vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "matugen" })
	
	vim.cmd("redraw!")
	print("✅ Complete!")
end

-- Setup autocmds and commands
function M.setup()
	-- Initial application
	local colors = M.apply()
	
	-- Apply plugin themes on startup
	local plugin_themes_ok, plugin_themes = pcall(require, "matugen.plugins")
	if plugin_themes_ok then
		plugin_themes.setup_all()
	end
	
	-- Auto-reload on signal
	vim.api.nvim_create_autocmd("Signal", {
		pattern = "SIGUSR1",
		callback = function()
			print("📡 Received SIGUSR1 signal")
			vim.schedule(M.reload)
		end,
	})
	
	-- Watch file with timer (more reliable)
	local last_modified = 0
	local function check_colors_file()
		local stat = vim.loop.fs_stat(M.COLORS_PATH)
		if stat and stat.mtime.sec > last_modified then
			last_modified = stat.mtime.sec
			if last_modified > 0 then
				print("📝 Colors file changed, reloading...")
				vim.schedule(M.reload)
			end
		end
	end
	
	-- Initialize last_modified
	local stat = vim.loop.fs_stat(M.COLORS_PATH)
	if stat then
		last_modified = stat.mtime.sec
	end
	
	-- Check every 2 seconds
	local timer = vim.loop.new_timer()
	timer:start(2000, 2000, vim.schedule_wrap(check_colors_file))
	
	-- Backup: BufWritePost watcher
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = M.COLORS_PATH,
		callback = function()
			print("📝 Detected file write")
			vim.schedule(function()
				vim.defer_fn(M.reload, 100)
			end)
		end,
	})
	
	-- Commands
	vim.api.nvim_create_user_command("MatugenReload", M.reload, {
		desc = "Reload Matugen colors",
	})
	
	vim.api.nvim_create_user_command("MatugenDebug", function()
		print("\n🔍 Matugen Debug:")
		print("Dynamic colors path: " .. M.COLORS_PATH)
		print("File exists: " .. tostring(vim.fn.filereadable(M.COLORS_PATH) == 1))
		
		if vim.fn.filereadable(M.COLORS_PATH) == 1 then
			local chunk = loadfile(M.COLORS_PATH)
			if chunk then
				local ok, loaded_colors = pcall(chunk)
				if ok then
					print("\n✓ Colors loaded from HOME:")
					for k, v in pairs(loaded_colors) do
						if type(v) == "string" and k:match("^[a-z]") then
							print("  " .. k .. " = " .. v)
						end
					end
				end
			end
		else
			print("\n! File not found, using fallback")
		end
		
		print("\nGlobal colors available: " .. tostring(_G.matugen_colors ~= nil))
		print("Current colorscheme: " .. (vim.g.colors_name or "none"))
	end, {
		desc = "Debug Matugen colors",
	})
end

return M