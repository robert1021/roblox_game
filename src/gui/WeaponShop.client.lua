local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")


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


RunService.RenderStepped:Connect(function()
	for i, v in game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopGui").Frame.ScrollingFrame:GetChildren() do
		if v:IsA("Frame") then
			v.UIStroke.UIGradient.Rotation += 2
		end
	end
end)