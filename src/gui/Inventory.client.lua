local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)
local inventoryButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryButtonGui").InventoryButton :: TextButton
local updatePlayerGoldInventoryRemoteEvent = ReplicatedStorage.UpdatePlayerGoldInventoryRemoteEvent :: RemoteEvent
local getPlayerInventoryRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerInventory

-- Inventory buttons
local weaponsButton = guiUtilities.getInventoryWeaponsButton()
local armorButton = guiUtilities.getInventoryArmorButton()
local potionsButton = guiUtilities.getInventoryPotionsButton()
local otherButton = guiUtilities.getInventoryOtherButton()


local isInventoryOpen = false


-- Functions


-- Events

inventoryButton.MouseButton1Click:Connect(function()
    if not isInventoryOpen then
        isInventoryOpen = true

        -- Load inventory
        local results = getPlayerInventoryRemoteFunc:InvokeServer()

        guiUtilities.addItemsInventory(results)
        guiUtilities.showInventoryCategory("Weapons")

    else
        isInventoryOpen = false
        guiUtilities.removeItemsInventory()
    end

    utility.ToggleInventory()
end)


weaponsButton.MouseButton1Click:Connect(function()
    guiUtilities.showInventoryCategory("Weapons")
end)


armorButton.MouseButton1Click:Connect(function()
    guiUtilities.showInventoryCategory("Armor")
end)


potionsButton.MouseButton1Click:Connect(function()
    guiUtilities.showInventoryCategory("Potions")
end)


otherButton.MouseButton1Click:Connect(function()
    guiUtilities.showInventoryCategory("Other")
end)



updatePlayerGoldInventoryRemoteEvent.OnClientEvent:Connect(function(playerGold)
    playerUtilities.GetInventoryGoldTextLabel().Text = playerGold
end)