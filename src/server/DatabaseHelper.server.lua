local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")



local PlayerDataStore = DataStoreService:GetDataStore("PlayerDataStore")
local Players = game:GetService("Players")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local weaponUtilities = require(ReplicatedStorage.Weapons)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)
local teleportUtilities = require(ReplicatedStorage.TeleportUtilities)

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
local weaponEquippedRemoteEvent = ReplicatedStorage.RemoteEvents.WeaponEquipped :: RemoteEvent
local loadPlayerBackpackRemoteEvent = ReplicatedStorage.RemoteEvents.LoadPlayerBackpack :: RemoteEvent
local buyItemMessageSuccess = ReplicatedStorage.RemoteEvents.BuyItemMessageSuccess :: RemoteEvent
local buyItemMessageFailed = ReplicatedStorage.RemoteEvents.BuyItemMessageFailed :: RemoteEvent
local dropItemRemoteEvent = ReplicatedStorage.RemoteEvents.DropItem :: RemoteEvent
local updateInventoryRemoteEvent = ReplicatedStorage.RemoteEvents.UpdateInventory :: RemoteEvent
local removeToolFromPlayerRemoteEvent = ReplicatedStorage.RemoteEvents.RemoveToolFromPlayer :: RemoteEvent
local removeAllToolsFromPlayer = ReplicatedStorage.RemoteEvents.RemoveAllToolsFromPlayer :: RemoteEvent
local openAfkAreaRemoteEvent = ReplicatedStorage.RemoteEvents.OpenAFKArea :: RemoteEvent
local closeAfkAreaRemoteEvent = ReplicatedStorage.RemoteEvents.CloseAFKArea :: RemoteEvent
local resetAfkAreaTimeRemoteEvent = ReplicatedStorage.RemoteEvents.ResetAFKAreaTime :: RemoteEvent
local updateAfkAreaTimeRemoteEvent = ReplicatedStorage.RemoteEvents.UpdateAFKAreaTime :: RemoteEvent
-- Remote Functions
local getPlayerInventoryRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerInventory
local getPlayerEquippedRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerEquipped :: RemoteFunction
local getPlayerAfkAreaTimeRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerAFKAreaTime :: RemoteFunction



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
		["afkAreaTime"] = {
			["minute"] = 0,
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
		-- Clone tool to player backpack
		tools[item]:Clone().Parent = player.Backpack
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
				data.inventory.weapons[weapon] = nil
				
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


local function resetPlayerAFKAreaTime(player)
	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.afkAreaTime.minute = 0
		
			return data
		end)
	end)

	if success then
		print("Reset " .. " minutes " .. " to 0 for " .. utility.GetPlayerName(player))
	else
		warn("Failed to reset time for player:", utility.GetPlayerName(player))
	end
end


local function addPlayerAFKAreaTime(player, minutes)
	local success, results = pcall(function()
		return PlayerDataStore:UpdateAsync(utility.GetDataStoreKey(player), function()
			local data = loadPlayerData(player)
			data.afkAreaTime.minute = data.afkAreaTime.minute + minutes
		
			return data
		end)
	end)

	if success then
		print("Added " .. minutes .. " minutes " .. " to " .. utility.GetPlayerName(player))
	else
		warn("Failed to add time to player:", utility.GetPlayerName(player))
	end
end


local function getPlayerAFKAreaTime(player)
	local data = loadPlayerData(player)

	if data ~= nil then return data.afkAreaTime.minute end
end




-- Events

Players.PlayerAdded:Connect(function(player)
	local data = loadPlayerData(player)

	if data then

		player.CharacterAdded:Connect(function(character)
			local humanoid = character:WaitForChild("Humanoid")
			-- TODO: Need to check if in any of the AFK Areas
			if utility.getIsAFKArea() then
				humanoid.Died:Connect(function()
					resetPlayerAFKAreaTime(player)
					teleportUtilities.TeleportPlayerToTownArea(player)
				end)

				openAfkAreaRemoteEvent:FireClient(player, 1)
				
			elseif utility.getIsAFKArea2() then
				humanoid.Died:Connect(function()
					resetPlayerAFKAreaTime(player)
					teleportUtilities.TeleportPlayerToTownArea(player)
				end)

				openAfkAreaRemoteEvent:FireClient(player, 2)
			else
				task.wait(0.2)
				setLevelRemoteEvent:FireClient(player, data.level)
				-- Get the percent complete of current level to update the exp bar completion
				local expTable = require(ReplicatedStorage.ExpTable)
				local percent = expTable.CalculatePercentLevelComplete(data.level, data.exp)
				updateExpBarCompletionRemoteEvent:FireClient(player, percent)
				
				updatePlayerGoldInventoryRemoteEvent:FireClient(player, getPlayerGold(player))
			
				local equipped = getPlayerEquipped(player)
				
					-- Equip and add events for all equipped weapons
				for _, v in ipairs(equipped) do
					equipItem(player, v)
					weaponEquippedRemoteEvent:FireClient(player, v)
				end

				-- Fire this event to client in case player was afk and reset character
				closeAfkAreaRemoteEvent:FireClient(player)
				
			end

		end)
		
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


equipItemRemoteEvent.OnServerEvent:Connect(function(player, item, type)
	equipItem(player, item)

	if type == "weapon" then
		weaponEquippedRemoteEvent:FireClient(player, item)
	end
	
end)


UnequipItemRemoteEvent.OnServerEvent:Connect(function(player, item)
	unequipItem(player, item)
end)


dropItemRemoteEvent.OnServerEvent:Connect(function(player, item, dropAmount)
	local amountDropped = removePlayerWeapons(player, item, dropAmount)

	if amountDropped ~= nil then

		local inventory = getPlayerInventory(player)

		if inventory.weapons[item] == nil then
			removeToolFromPlayerRemoteEvent:FireClient(player, item)	
		end
		
		utility.dropToolInGame(item, amountDropped)
		-- Fire event to update inventory
		updateInventoryRemoteEvent:FireClient(player)
		
	end
	
	
end)


resetAfkAreaTimeRemoteEvent.OnServerEvent:Connect(function(player)
	resetPlayerAFKAreaTime(player)
end)


updateAfkAreaTimeRemoteEvent.OnServerEvent:Connect(function(player, minutes)
	addPlayerAFKAreaTime(player, minutes)
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


getPlayerAfkAreaTimeRemoteFunc.OnServerInvoke = function(player)
	local minutes = getPlayerAFKAreaTime(player)
	return minutes
end







