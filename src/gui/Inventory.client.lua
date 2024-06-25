local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local inventoryButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryButtonGui").InventoryButton :: TextButton
local updatePlayerGoldInventoryRemoteEvent = ReplicatedStorage.UpdatePlayerGoldInventoryRemoteEvent :: RemoteEvent

-- Events

inventoryButton.MouseButton1Click:Connect(function()
    utility.ToggleInventory()
end)



updatePlayerGoldInventoryRemoteEvent.OnClientEvent:Connect(function(playerGold)
    playerUtilities.GetInventoryGoldTextLabel().Text = playerGold
end)