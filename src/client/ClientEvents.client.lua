local ReplicatedStorage = game:GetService("ReplicatedStorage")

local potionShopAreaRemoveEvent = ReplicatedStorage.PotionShopAreaRemoteEvent
local armorShopAreaRemoveEvent = ReplicatedStorage.ArmorShopAreaRemoteEvent
local weaponShopAreaRemoveEvent = ReplicatedStorage.WeaponShopAreaRemoteEvent
local travelingMerchantShopAreaRemoveEvent = ReplicatedStorage.TravelingMerchantShopAreaRemoteEvent
local afkAreaRemoteEvent = ReplicatedStorage.AFKAreaRemoteEvent
local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)

local addExpRemoteEvent = ReplicatedStorage.AddExpRemoteEvent


-- Events

potionShopAreaRemoveEvent.OnClientEvent:Connect(function(part)
	utility.TogglePartTransparency(part, 0.8)
	-- Show shop button on local player's screen
	utility.TogglePotionShopButtonGui()
end)


armorShopAreaRemoveEvent.OnClientEvent:Connect(function(part)
	utility.TogglePartTransparency(part, 0.8)
	-- Show shop button on local player's screen
	utility.ToggleArmorShopButtonGui()
end)


weaponShopAreaRemoveEvent.OnClientEvent:Connect(function(part)
	utility.TogglePartTransparency(part, 0.8)
	-- Show shop button on local player's screen
	utility.ToggleWeaponShopButtonGui()
end)


travelingMerchantShopAreaRemoveEvent.OnClientEvent:Connect(function(part)
	utility.TogglePartTransparency(part, 0.8)
	-- Show shop button on local player's screen
	utility.ToggleTravelingMercahntShopButtonGui()
end)


afkAreaRemoteEvent.OnClientEvent:Connect(function(part)
	utility.TogglePartTransparency(part, 0.8)
	-- Show AFK button on local player's screen
	utility.ToggleAFKButtonGui()
	
end)