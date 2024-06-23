local ReplicatedStorage = game:GetService("ReplicatedStorage")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local weaponShopButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopButtonGui").ShopButton
local weaponShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopGui").Frame.CloseButton


-- Events

-- Weapon Shop --

weaponShopButton.MouseButton1Click:Connect(function()
	utility.ToggleWeaponShop()
end)

weaponShopCloseButton.MouseButton1Click:Connect(function()
	utility.ToggleWeaponShop()
end)
