local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerDataStore")
local Players = game:GetService("Players")

local utility = require(ReplicatedStorage.UtilityModuleScript)

-- Remote events
local addExpRemoteEvent = ReplicatedStorage.AddExpRemoteEvent
local levelUpRemoteEvent = ReplicatedStorage.LevelUpRemoteEvent
local setLevelRemoteEvent = ReplicatedStorage.SetLevelRemoteEvent

-- Remote Functions



-- Functions

local function createPlayerData(player)
	local playerData = {
		["level"] = 1,
		["gold"] = 0,
		["exp"] = 0,
	}
	
	local saveSuccess, saveError = pcall(function()
		PlayerDataStore:SetAsync(utility.GetDataStoreKey(player), playerData)
	end)
	
	if saveSuccess then
		print("Player data added successfully.")
	else
		warn("Failed to save player data:", saveError)
	end
	
end


local function loadPlayerData(player)
	local success, data = pcall(function()
		return PlayerDataStore:GetAsync(utility.GetDataStoreKey(player))
	end)

	if success then
		return data
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



-- Events

Players.PlayerAdded:Connect(function(player)
	local data = loadPlayerData(player)
	print(data)

	if data == nil then
		createPlayerData(player)

	else
		setLevelRemoteEvent:FireClient(player, data.level)
		

	end
	
end)


addExpRemoteEvent.OnServerEvent:Connect(function(player, exp)
	local data = loadPlayerData(player)

	if data ~= nil then
		local expTable = require(ReplicatedStorage.ExpTable)
		local playerExp = data.exp
		local playerLevel = data.level

		addPlayerExp(player, exp)


		if (playerExp + exp) > expTable[playerLevel] then
			-- print("level up..")
			-- addPlayerLevel(player, level)
			-- levelUpRemoteEvent:FireClient(player, level)
		end

	end

	print(exp)
	-- level up player if meets requirements
	-- local level = 2
	-- levelUpRemoteEvent:FireClient(player, level)
end)





-- Remote Functions







