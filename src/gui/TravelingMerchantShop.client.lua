local ReplicatedStorage = game:GetService("ReplicatedStorage")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local travelingMerchantShopButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TravelingMerchantShopButtonGui").ShopButton
local travelingMerchantShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TravelingMerchantShopGui").Frame.CloseButton


-- Events

-- Traveling Merchant Shop --

travelingMerchantShopButton.MouseButton1Click:Connect(function()
	utility.ToggleTravelingMerchantShop()
end)

travelingMerchantShopCloseButton.MouseButton1Click:Connect(function()
	utility.ToggleTravelingMerchantShop()
end)