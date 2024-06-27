local module = {
	["startAreaId"] = 17872213831,
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

function module.SetPartTransparency(part, amount)
	part.Transparency = amount
end

function module.GetPartTransparency(part)
	return part.Transparency
end

function module.TogglePartTransparency(part, amount)
	if module.GetPartTransparency(part) == 1 then
		module.SetPartTransparency(part, amount)
	else
		module.SetPartTransparency(part, 1)
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

function module.ToggleInventory()
	local inventoryGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")
	local inventoryButtonGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryButtonGui")
	local inventoryButton = inventoryButtonGui.InventoryButton

	if inventoryGui then

		if inventoryGui.Enabled == true then
			inventoryGui.Enabled = false
			module.SetPartTransparency(inventoryButton, 0.2)
		else
			inventoryGui.Enabled = true
			module.SetPartTransparency(inventoryButton, 0)
		end

	end

end

function module.PlayLevelUpSound()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local sound = ReplicatedStorage.Sounds.LevelUp

	sound:Play()
end

function module.GetPotionShopButton()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
	return playerUtilities.GetLocalPlayer().PlayerGui:FindFirstChild("PotionShopButtonGui").ShopButton
end


function module.animateShopButton(button)
	local TweenService = game:GetService("TweenService") 

	local gradient = button.UIGradient
	local ti = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
	local offset1 = {Offset = Vector2.new(1, 0)}
	local create = TweenService:Create(gradient, ti, offset1)
	local startingPos = Vector2.new(-1, 0) --start on the right, tween to the left so it looks like the shine went from left to right
	local addWait = 1.5 --the amount of seconds between each couplet of shines

	create:Play()
	create.Completed:Wait()
	gradient.Offset = startingPos
	create:Play()
	create.Completed:Wait()
	gradient.Offset = startingPos
	wait(addWait)
	module.animateShopButton(button)
	
end

function module.GetIsTownArea()
	if game.PlaceId == module.startAreaId then
		return true
	else
		return false
	end
end

function module.GetIsBattleArea()
	if game.PlaceId == module.BattleAreaID then
		return true
	else
		return false
	end
end

return module
