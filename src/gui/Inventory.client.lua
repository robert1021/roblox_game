local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local inventoryButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryButtonGui").InventoryButton :: TextButton

-- Events

inventoryButton.MouseButton1Click:Connect(function()
    utility.ToggleInventory()
end)

