local ReplicatedStorage = game:GetService("ReplicatedStorage")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local armorShopButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ArmorShopButtonGui").ShopButton
local armorShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ArmorShopGui").Frame.CloseButton


-- Events

-- Armor Shop --

armorShopButton.MouseButton1Click:Connect(function()
	utility.ToggleArmorShop()
end)

armorShopCloseButton.MouseButton1Click:Connect(function()
	utility.ToggleArmorShop()
end)
