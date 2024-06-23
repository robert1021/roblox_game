local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)

local armorShopModel = game.Workspace.ShopArea.ArmorShop
local armorShopTouchPart = armorShopModel.ShopZone.TouchPart
local armorShopBoundary = armorShopTouchPart.Parent.Boundary
local armorShopPlayers = {}
local armorShopAreaRemoveEvent = ReplicatedStorage.ArmorShopAreaRemoteEvent

local potionShopModel = game.Workspace.ShopArea.PotionShop
local potionShopTouchPart = potionShopModel.ShopZone.TouchPart
local potionShopBoundary = potionShopTouchPart.Parent.Boundary
local potionShopPlayers = {}
local potionShopAreaRemoveEvent = ReplicatedStorage.PotionShopAreaRemoteEvent

local weaponShopModel = game.Workspace.ShopArea.WeaponShop
local weaponShopTouchPart = weaponShopModel.ShopZone.TouchPart
local weaponShopBoundary = weaponShopTouchPart.Parent.Boundary
local weaponShopPlayers = {}
local weaponShopAreaRemoveEvent = ReplicatedStorage.WeaponShopAreaRemoteEvent

local travelingMerchantModel = game.Workspace.ShopArea.TravelingMerchant
local travelingMerchantTouchPart = travelingMerchantModel.ShopZone.TouchPart
local travelingMerchantBoundary = travelingMerchantTouchPart.Parent.Boundary
local travelingMerchantPlayers = {}
local travelingMerchantShopAreaRemoveEvent = ReplicatedStorage.TravelingMerchantShopAreaRemoteEvent
local timerPartTravelingMerchant = travelingMerchantModel.TimerPart
local timerPartTravelingMerchantTextLabel = timerPartTravelingMerchant.BillboardGui.TextLabel
local travelingMerchantMinutes = 15
local travelingMerchantSeconds = 0





-- Events

-- Armor Shop --

armorShopTouchPart.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if armorShopPlayers[playerName] == nil then
		armorShopPlayers[playerName] = 0
		armorShopAreaRemoveEvent:FireClient(player, armorShopTouchPart)
	end

end)


armorShopBoundary.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if armorShopPlayers[playerName] ~= nil then
		armorShopPlayers[playerName] = nil
		armorShopAreaRemoveEvent:FireClient(player, armorShopTouchPart)
	end

end)

-- Potion Shop --

potionShopTouchPart.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if potionShopPlayers[playerName] == nil then
		potionShopPlayers[playerName] = 0
		potionShopAreaRemoveEvent:FireClient(player, potionShopTouchPart)
	end

end)



potionShopBoundary.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if potionShopPlayers[playerName] ~= nil then
		potionShopPlayers[playerName] = nil
		potionShopAreaRemoveEvent:FireClient(player, potionShopTouchPart)
	end

end)


-- Weapon Shop --

weaponShopTouchPart.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if weaponShopPlayers[playerName] == nil then
		weaponShopPlayers[playerName] = 0
		weaponShopAreaRemoveEvent:FireClient(player, weaponShopTouchPart)
	end

end)


weaponShopBoundary.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if weaponShopPlayers[playerName] ~= nil then
		weaponShopPlayers[playerName] = nil
		weaponShopAreaRemoveEvent:FireClient(player, weaponShopTouchPart)
	end

end)


-- traveling Merchant --

travelingMerchantTouchPart.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if travelingMerchantPlayers[playerName] == nil then
		travelingMerchantPlayers[playerName] = 0
		travelingMerchantShopAreaRemoveEvent:FireClient(player, travelingMerchantTouchPart)
	end

end)


travelingMerchantBoundary.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if travelingMerchantPlayers[playerName] ~= nil then
		travelingMerchantPlayers[playerName] = nil
		travelingMerchantShopAreaRemoveEvent:FireClient(player, travelingMerchantTouchPart)
	end

end)


while true do


	if travelingMerchantMinutes == 0 and travelingMerchantSeconds == 0 then
		-- hide merchant
		utility.ToggleTravelingMerchant()

		-- reset timer

		travelingMerchantMinutes = 15
		travelingMerchantSeconds = 0

	elseif travelingMerchantSeconds == 0 then
		travelingMerchantMinutes -= 1
		travelingMerchantSeconds = 59
	elseif travelingMerchantSeconds ~= 0 then
		travelingMerchantSeconds -= 1
	end


	-- Update UI
	if travelingMerchantSeconds < 10 then
		timerPartTravelingMerchantTextLabel.Text = tostring(travelingMerchantMinutes) .. ":" .. "0" ..tostring(travelingMerchantSeconds)
	else
		timerPartTravelingMerchantTextLabel.Text = tostring(travelingMerchantMinutes) .. ":" .. tostring(travelingMerchantSeconds)
	end

	task.wait(1)
end