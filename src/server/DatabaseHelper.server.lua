local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")


local PlayerDataStore = DataStoreService:GetDataStore("PlayerDataStore")
local Players = game:GetService("Players")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local weaponUtilities = require(ReplicatedStorage.Weapons)

local tools = ReplicatedStorage.Tools

-- Remote events
local addExpRemoteEvent = ReplicatedStorage.AddExpRemoteEvent
local levelUpRemoteEvent = ReplicatedStorage.LevelUpRemoteEvent
local setLevelRemoteEvent = ReplicatedStorage.SetLevelRemoteEvent
local updateExpBarCompletionRemoteEvent = ReplicatedStorage.UpdateExpBarCompletionRemoteEvent
local addPlayerGoldRemoteEvent = ReplicatedStorage.AddPlayerGoldRemoteEvent
local removePlayerGoldRemoteEvent = ReplicatedStorage.RemovePlayerGoldRemoteEvent
local updatePlayerGoldInventoryRemoteEvent = ReplicatedStorage.UpdatePlayerGoldInventoryRemoteEvent
local buyWeaponRemoteEvent = ReplicatedStorage.RemoteEvents.BuyWeaponRemoteEvent :: RemoteEvent
local equipItemRemoteEvent = ReplicatedStorage.RemoteEvents.EquipItem :: RemoteEvent
local UnequipItemRemoteEvent = ReplicatedStorage.RemoteEvents.UnequipItem :: RemoteEvent
local loadPlayerBackpackRemoteEvent = ReplicatedStorage.RemoteEvents.LoadPlayerBackpack :: RemoteEvent
local buyItemMessageSuccess = ReplicatedStorage.RemoteEvents.BuyItemMessageSuccess :: RemoteEvent
local buyItemMessageFailed = ReplicatedStorage.RemoteEvents.BuyItemMessageFailed :: RemoteEvent
local dropItemRemoteEvent = ReplicatedStorage.RemoteEvents.DropItem :: RemoteEvent
-- Remote Functions
local getPlayerInventoryRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerInventory
local getPlayerEquippedRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerEquipped :: RemoteFunction



-- Functions

local function createPlayerData(player)
	local playerData = {
		["level"] = 1,
		["gold"] = 0,
		["exp"] = 0,
		["inventory"] = {
			["weapons"] = {},
			["armor"] = {},
			["potions"] = {}

		},
	}
	
	local saveSuccess, saveError = pcall(function()
		PlayerDataStore:SetAsync(utility.GetDataStoreKey(player), playerData)
	end)
	
	if saveSuccess then
		print("Player data added successfully.")
		return playerData
	else
		warn("Failed to save player data:", saveError)
		return nil
	end
	
end


local function loadPlayerData(player)
	local success, data = pcall(function()
		return PlayerDataStore:GetAsync(utility.GetDataStoreKey(player))
	end)

	if success then
		if data then
			return data
		else
			return createPlayerData(player)
		end
	else
		warn("Failed to load player data:", data)
		return nil
	end
end

local function deletePlayerData(player)
	
	local data = loadPlayerData(player)
	
	if data ~= nil then
		
		local saveSuccess, saveError = pcall(function()
			PlayerDataStore:SetAsync(utility.GetDataStoreKey(player), {})
		end)
		
		if saveSuccess then
			print("Player data " .. "for " .. utility.GetPlayerName(player) .. " deleted successfully.")
		else
			warn("Failed to delete player data:", saveError)
		end
		
	end
	
end

local function deleteAllPlayerData()
	local Success, Pages = pcall(function()
		return PlayerDataStore:ListKeysAsync()
	end)
	
	while task.wait() do
	
		local Items = Pages:GetCurrentPage()
	
		for _, Data in ipairs(Items) do
	
			local Key = Data.KeyName
			PlayerDataStore:RemoveAsync(Key)
	
		end
	
		if Pages.IsFinished then break else Pages:AdvanceToNextPageAsync() end
	
	end
	
	print("Done")

end

local function getPlayerGold(player)
	
	local data = loadPlayerData(player)
	
	if data ~= nil then return data.gold end
	
end


local function addPlayerGold(player, amount)
	
	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.gold = data.gold + amount
			return data
		end)
	end)
	
	if success then
		print("Added " .. tostring(amount) .. " gold to " .. utility.GetPlayerName(player))
	else
		warn("Failed to add gold to player:", utility.GetPlayerName(player))
	end
end


local function removePlayerGold(player, amount)
	
	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.gold = data.gold - amount
			return data
		end)
	end)
	
	if success then
		print("Removed " .. tostring(amount) .. " gold from " .. utility.GetPlayerName(player))
	else
		warn("Failed to remove gold from player:", utility.GetPlayerName(player))
	end
end


local function getPlayerExp(player)

	local data = loadPlayerData(player)

	if data ~= nil then return data.exp end

end


local function addPlayerExp(player, amount)

	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.exp = data.exp + amount
			return data
		end)
	end)

	if success then
		print("Added " .. tostring(amount) .. " exp to " .. utility.GetPlayerName(player))
	else
		warn("Failed to add exp to player:", utility.GetPlayerName(player))
	end
end


local function getPlayerLevel(player)

	local data = loadPlayerData(player)

	if data ~= nil then return data.level end

end


local function addPlayerLevel(player, amount)

	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.level = data.level + amount
			return data
		end)
	end)

	if success then
		print("Added " .. tostring(amount) .. " level to " .. utility.GetPlayerName(player))
	else
		warn("Failed to add level to player:", utility.GetPlayerName(player))
	end
end


local function addPlayerWeapon(player, weapon)

	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			
			if data.inventory.weapons[weapon] == nil then
				data.inventory.weapons[weapon] = {
					["count"] = 1,
					["equipped"] = false
				}

			else
				data.inventory.weapons[weapon]["count"] += 1
			end
			
			return data
		end)
	end)

	if success then
		print("Added " .. weapon .. " to " .. utility.GetPlayerName(player))
	else
		warn("Failed to add weapon to player:", utility.GetPlayerName(player))
	end

end





local function getPlayerInventory(player)
	local data = loadPlayerData(player)

	if data ~= nil then return data.inventory end
end


local function getPlayerEquipped(player)
	local data = loadPlayerData(player)
	local equipped = {}

	if data ~= nil then
		for k, v in pairs(data.inventory.weapons) do
			if data.inventory.weapons[k]["equipped"] then table.insert(equipped, k) end
		end
	end

	return equipped
end


local function equipItem(player, item)

	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.inventory.weapons[item]["equipped"] = true
			return data
		end)
	end)

	if success then
		print("Equipped " .. item .. " to " .. utility.GetPlayerName(player))

		for _, child in tools:GetChildren() do
			if child.Name == item then
				local tool = child:Clone()
				tool.Parent = player.Backpack
				break
			end
		end
	else
		warn("Failed to equip to player:", utility.GetPlayerName(player))
	end

end


local function unequipItem(player, item)

	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.inventory.weapons[item]["equipped"] = false
			
			return data
		end)
	end)

	if success then
		print("Unequipped " .. item .. " from " .. utility.GetPlayerName(player))
	else
		warn("Failed to equip to player:", utility.GetPlayerName(player))
	end

end


local function removePlayerWeapon(player, weapon)

	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.inventory.weapons[weapon]["count"] -= 1
		
			return data
		end)
	end)

	if success then
		print("Removed " .. weapon .. " from " .. utility.GetPlayerName(player))
	else
		warn("Failed to remove weapon from player:", utility.GetPlayerName(player))
	end

end


local function removePlayerWeapons(player, weapon, amount)
	local amountDropped = 0

	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)

			if data.inventory.weapons[weapon]["count"] - amount <= 0  then
				amountDropped = data.inventory.weapons[weapon]["count"]

				-- TODO: Need to remove weapon from database


				
			else
				amountDropped = amount
				data.inventory.weapons[weapon]["count"] -= amount
			end
			
			return data
		end)
	end)

	if success then
		print("Removed " .. weapon .. " from " .. utility.GetPlayerName(player))
		return amountDropped
	else
		warn("Failed to remove weapon from player:", utility.GetPlayerName(player))
		return nil
	end

end


-- Events

Players.PlayerAdded:Connect(function(player)
	local data = loadPlayerData(player)

	if data then
		setLevelRemoteEvent:FireClient(player, data.level)
		-- Get the percent complete of current level to update the exp bar completion
		local expTable = require(ReplicatedStorage.ExpTable)
		local percent = expTable.CalculatePercentLevelComplete(data.level, data.exp)
		updateExpBarCompletionRemoteEvent:FireClient(player, percent)
		updatePlayerGoldInventoryRemoteEvent:FireClient(player, getPlayerGold(player))
		loadPlayerBackpackRemoteEvent:FireClient(player, getPlayerEquipped(player))
		
	else
		warn("Failed to initialize player data for player:", utility.GetPlayerName(player))
	end
		
end)


addExpRemoteEvent.OnServerEvent:Connect(function(player, exp)
	local data = loadPlayerData(player)

	if data ~= nil then
		local expTable = require(ReplicatedStorage.ExpTable)
		local playerExp = data.exp
		local playerLevel = data.level

		addPlayerExp(player, exp)

		local newLevel = expTable.CalculateCurrentLevelWithExp(playerExp + exp)

		if newLevel > playerLevel then
			
			addPlayerLevel(player, newLevel - playerLevel)
			levelUpRemoteEvent:FireClient(player, newLevel)
		end
		
		-- Get the percent complete of current level to update the exp bar completion
		local percent = expTable.CalculatePercentLevelComplete(getPlayerLevel(player), playerExp + exp)
		updateExpBarCompletionRemoteEvent:FireClient(player, percent)

	end

end)


addPlayerGoldRemoteEvent.OnServerEvent:Connect(function(player, amount)
	local data = loadPlayerData(player)

	if data ~= nil then
		addPlayerGold(player, amount)
		updatePlayerGoldInventoryRemoteEvent:FireClient(player, getPlayerGold(player))
	end
end)


removePlayerGoldRemoteEvent.OnServerEvent:Connect(function(player, amount)
	local data = loadPlayerData(player)

	if data ~= nil then
		removePlayerGold(player, amount)
		updatePlayerGoldInventoryRemoteEvent:FireClient(player, getPlayerGold(player))
	end
end)


buyWeaponRemoteEvent.OnServerEvent:Connect(function(player, weapon)
	local gold = getPlayerGold(player)
	local weaponPrice = weaponUtilities.getWeaponPrice(weapon)
	
	if (gold - weaponPrice) >= 0 then
		removePlayerGold(player, weaponPrice)
		updatePlayerGoldInventoryRemoteEvent:FireClient(player, getPlayerGold(player))
		addPlayerWeapon(player, weapon)
		buyItemMessageSuccess:FireClient(player)
	else
		buyItemMessageFailed:FireClient(player)
	end
	
end)


equipItemRemoteEvent.OnServerEvent:Connect(function(player, item)
	equipItem(player, item)
end)


UnequipItemRemoteEvent.OnServerEvent:Connect(function(player, item)
	unequipItem(player, item)
end)


dropItemRemoteEvent.OnServerEvent:Connect(function(player, item, dropAmount)
	local amountDropped = removePlayerWeapons(player, item, dropAmount)

	print(amountDropped)

	-- if amountDropped ~= nil then
	-- 	print(tostring(amountDropped))
	-- 	playerUtilities.dropToolFromPlayer(player, item)
	-- end
	
	
end)

-- Remote Functions

getPlayerInventoryRemoteFunc.OnServerInvoke = function(player)
	local inventory = getPlayerInventory(player)
	return inventory
end


getPlayerEquippedRemoteFunc.OnServerInvoke = function(player)
	local equipped = getPlayerEquipped(player)
	return equipped
end




