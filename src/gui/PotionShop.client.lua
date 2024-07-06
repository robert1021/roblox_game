local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)

local potionShopButton = utility.GetPotionShopButton()
local potionShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PotionShopGui").Frame.CloseButton

local inventoryGui = guiUtilities.getInventoryGui()
local inventoryButtonGui = guiUtilities.getInventoryButtonGui()

-- Events

-- Potion Shop --

potionShopButton.MouseButton1Click:Connect(function()
	-- close inventory and hide button
	inventoryGui.Enabled = false
	inventoryButtonGui.Enabled = false


	utility.TogglePotionShop()
end)

potionShopCloseButton.MouseButton1Click:Connect(function()
	-- Enable inventory when shop closed
	inventoryButtonGui.Enabled = true
	-- Hide the message gui's
	guiUtilities.hideBuyItemMessageSuccess()
	guiUtilities.hideBuyItemMessageFailed()


	utility.TogglePotionShop()
end)


RunService.RenderStepped:Connect(function()
	for i, v in game.Players.LocalPlayer.PlayerGui:FindFirstChild("PotionShopGui").Frame.ScrollingFrame:GetChildren() do
		if v:IsA("Frame") then
			v.UIStroke.UIGradient.Rotation += 2
		end
	end
end)


guiUtilities.animateShopButton(potionShopButton)