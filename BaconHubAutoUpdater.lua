-- 🧠 BaconHub Smart Loader (always loads latest version)
local repoURL = "https://raw.githubusercontent.com/BaconHub1/My-script/refs/heads/main/Baconhub" -- 🔁 Put your actual GitHub raw link here

local success, response = pcall(function()
    return game:HttpGet(repoURL)
end)

if success then
    local fn, err = loadstring(response)
    if fn then
        print("✅ BaconHub loaded from GitHub.")
        fn()
    else
        warn("❌ Failed to run BaconHub: " .. err)
    end
else
    warn("❌ Failed to fetch BaconHub from GitHub.")
end
