local module = {
	["BattleAreaID"] = 17872891022
}

function module.GetHumanoidFromPart(part)
	
	local model = part:FindFirstAncestorWhichIsA("Model")
	
	if model then
		local humanoid = model:FindFirstChildWhichIsA("Humanoid")
		
		if humanoid then return humanoid end
		
	end
	
	return nil
	
end

function module.GetPlayerFromHumanoid(humanoid)
	
	local PlayersService = game:GetService("Players")
	return PlayersService:GetPlayerFromCharacter(humanoid.Parent)
	
end

function module.GetPlayerFromPart(part)
	
	local humanoid = module.GetHumanoidFromPart(part)
	
	if humanoid == nil then
		return nil
	else 
		return module.GetPlayerFromHumanoid(humanoid)
	end
	
end

function module.GetPlayerName(player)
	return player.Name
end

function module.GetPlayerUserId(player)
	return player.UserId
end

function module.TeleportPlayer(areaID, player)
	local TeleportService = game:GetService("TeleportService")
	TeleportService:Teleport(areaID, player)
	
end

function module.TeleportPlayerToBattleArea(player)
	module.TeleportPlayer(module.BattleAreaID, player)
end

function module.TogglePartTransparency(part, amount)
	
	if part.Transparency == 1 then
		part.Transparency = amount
	else
		part.Transparency = 1
	end
	
end


function module.TogglePotionShopButtonGui()
	local shopButtonGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PotionShopButtonGui")
	
	if shopButtonGui then
		
		if shopButtonGui.Enabled == true then
			shopButtonGui.Enabled = false
		else
			shopButtonGui.Enabled = true
		end
		
	end

end


function module.ToggleArmorShopButtonGui()
	local shopButtonGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ArmorShopButtonGui")

	if shopButtonGui then

		if shopButtonGui.Enabled == true then
			shopButtonGui.Enabled = false
		else
			shopButtonGui.Enabled = true
		end

	end

end


function module.ToggleWeaponShopButtonGui()
	local shopButtonGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopButtonGui")

	if shopButtonGui then

		if shopButtonGui.Enabled == true then
			shopButtonGui.Enabled = false
		else
			shopButtonGui.Enabled = true
		end

	end

end


function module.ToggleTravelingMercahntShopButtonGui()
	local shopButtonGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TravelingMerchantShopButtonGui")

	if shopButtonGui then

		if shopButtonGui.Enabled == true then
			shopButtonGui.Enabled = false
		else
			shopButtonGui.Enabled = true
		end

	end

end


function module.ToggleAFKButtonGui()
	local afkButtonGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("AFKButtonGui")

	if afkButtonGui then

		if afkButtonGui.Enabled == true then
			afkButtonGui.Enabled = false
		else
			afkButtonGui.Enabled = true
		end

	end

end


function module.TogglePotionShop()
	local shopGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PotionShopGui")
	
	if shopGui then
		
		if shopGui.Enabled == true then
			shopGui.Enabled = false
		else
			shopGui.Enabled = true
		end
		
	end
	
end


function module.ToggleArmorShop()
	local shopGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ArmorShopGui")

	if shopGui then

		if shopGui.Enabled == true then
			shopGui.Enabled = false
		else
			shopGui.Enabled = true
		end

	end

end


function module.ToggleWeaponShop()
	local shopGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopGui")

	if shopGui then

		if shopGui.Enabled == true then
			shopGui.Enabled = false
		else
			shopGui.Enabled = true
		end

	end

end


function module.ToggleTravelingMerchantShop()
	local shopGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TravelingMerchantShopGui")

	if shopGui then

		if shopGui.Enabled == true then
			shopGui.Enabled = false
		else
			shopGui.Enabled = true
		end

	end

end


function module.ToggleTravelingMerchant()
	local ServerStorage = game:GetService("ServerStorage")
	local travelingMerchant = game.Workspace.ShopArea.TravelingMerchant
	
	
	if travelingMerchant:FindFirstChild("LowPolyShop") and travelingMerchant:FindFirstChild("ShopZone") then
		travelingMerchant.LowPolyShop.Parent = ServerStorage
		travelingMerchant.ShopZone.Parent = ServerStorage
		
	else
		ServerStorage.LowPolyShop.Parent = travelingMerchant
		ServerStorage.ShopZone.Parent = travelingMerchant
	end
		
	
end


function module.GetDataStoreKey(player)
	return "PlayerData_" .. module.GetPlayerUserId(player)
end

return module
