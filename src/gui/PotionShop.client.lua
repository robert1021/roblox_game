local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local potionShopButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PotionShopButtonGui").ShopButton
local potionShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PotionShopGui").Frame.CloseButton



-- Events

-- Potion Shop --

potionShopButton.MouseButton1Click:Connect(function()
	utility.TogglePotionShop()
end)

potionShopCloseButton.MouseButton1Click:Connect(function()
	utility.TogglePotionShop()
end)


RunService.RenderStepped:Connect(function()
	for i, v in game.Players.LocalPlayer.PlayerGui:FindFirstChild("PotionShopGui").Frame.ScrollingFrame:GetChildren() do
		if v:IsA("Frame") then
			v.UIStroke.UIGradient.Rotation += 2
		end
	end
end)