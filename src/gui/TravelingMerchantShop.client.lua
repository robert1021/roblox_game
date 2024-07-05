local ReplicatedStorage = game:GetService("ReplicatedStorage")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)


local travelingMerchantShopButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TravelingMerchantShopButtonGui").ShopButton
local travelingMerchantShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TravelingMerchantShopGui").Frame.CloseButton

local inventoryGui = guiUtilities.getInventoryGui()
local inventoryButtonGui = guiUtilities.getInventoryButtonGui()


-- Events

-- Traveling Merchant Shop --

travelingMerchantShopButton.MouseButton1Click:Connect(function()
	-- close inventory and hide button
	inventoryGui.Enabled = false
	inventoryButtonGui.Enabled = false


	utility.ToggleTravelingMerchantShop()
end)

travelingMerchantShopCloseButton.MouseButton1Click:Connect(function()
	-- Enable inventory when shop closed
	inventoryButtonGui.Enabled = true


	utility.ToggleTravelingMerchantShop()
end)



guiUtilities.animateShopButton(travelingMerchantShopButton)