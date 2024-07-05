local ReplicatedStorage = game:GetService("ReplicatedStorage")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)


local armorShopButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ArmorShopButtonGui").ShopButton
local armorShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ArmorShopGui").Frame.CloseButton

local inventoryGui = guiUtilities.getInventoryGui()
local inventoryButtonGui = guiUtilities.getInventoryButtonGui()


-- Events

-- Armor Shop --

armorShopButton.MouseButton1Click:Connect(function()
	-- close inventory and hide button
	inventoryGui.Enabled = false
	inventoryButtonGui.Enabled = false


	utility.ToggleArmorShop()
end)

armorShopCloseButton.MouseButton1Click:Connect(function()
	-- Enable inventory when shop closed
	inventoryButtonGui.Enabled = true


	utility.ToggleArmorShop()
end)


guiUtilities.animateShopButton(armorShopButton)