local ReplicatedStorage = game:GetService("ReplicatedStorage")

local tools = ReplicatedStorage.Tools
local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)
local inventoryUtilities = require(ReplicatedStorage.InventoryUtilities)
local inventoryButton = guiUtilities.getInventoryButton()
local updatePlayerGoldInventoryRemoteEvent = ReplicatedStorage.UpdatePlayerGoldInventoryRemoteEvent :: RemoteEvent
local loadPlayerBackpackRemoteEvent = ReplicatedStorage.RemoteEvents.LoadPlayerBackpack :: RemoteEvent
local updateInventoryRemoteEvent = ReplicatedStorage.RemoteEvents.UpdateInventory :: RemoteEvent
local removeAllToolsFromPlayer = ReplicatedStorage.RemoteEvents.RemoveAllToolsFromPlayer :: RemoteEvent
local removeToolFromPlayerRemoteEvent = ReplicatedStorage.RemoteEvents.RemoveToolFromPlayer :: RemoteEvent
local weaponEquippedRemoteEvent = ReplicatedStorage.RemoteEvents.WeaponEquipped :: RemoteEvent
local getPlayerInventoryRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerInventory :: RemoteFunction
local getPlayerEquippedRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerEquipped :: RemoteFunction

local inventoryGui = guiUtilities.getInventoryGui()
-- Inventory buttons
local weaponsButton = guiUtilities.getInventoryWeaponsButton()
local armorButton = guiUtilities.getInventoryArmorButton()
local potionsButton = guiUtilities.getInventoryPotionsButton()
local otherButton = guiUtilities.getInventoryOtherButton()


-- local isInventoryOpen = false


-- Functions


-- Events

inventoryButton.MouseButton1Click:Connect(function()
    local sound = utility.createSound(weaponsButton, inventoryUtilities.Sounds.Equip, 0.5)
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
    if not inventoryGui.Enabled then

        guiUtilities.removeItemsInventory()
        -- Load inventory
        local results = getPlayerInventoryRemoteFunc:InvokeServer()

        guiUtilities.addItemsInventory(results)
        guiUtilities.selectInventoryCategoryButton("Weapons")
        guiUtilities.showInventoryCategory("Weapons")

    else
        guiUtilities.removeItemsInventory()
    end
    utility.ToggleInventory()
end)


weaponsButton.MouseButton1Click:Connect(function()
    local sound = utility.createSound(weaponsButton, inventoryUtilities.Sounds.Equip, 0.5)
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
    guiUtilities.selectInventoryCategoryButton("Weapons")
    guiUtilities.showInventoryCategory("Weapons")
end)


armorButton.MouseButton1Click:Connect(function()
    local sound = utility.createSound(weaponsButton, inventoryUtilities.Sounds.Equip, 0.5)
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
    guiUtilities.selectInventoryCategoryButton("Armor")
    guiUtilities.showInventoryCategory("Armor")
end)


potionsButton.MouseButton1Click:Connect(function()
    local sound = utility.createSound(weaponsButton, inventoryUtilities.Sounds.Equip, 0.5)
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
    guiUtilities.selectInventoryCategoryButton("Potions")
    guiUtilities.showInventoryCategory("Potions")
end)


otherButton.MouseButton1Click:Connect(function()
    local sound = utility.createSound(weaponsButton, inventoryUtilities.Sounds.Equip, 0.5)
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
    guiUtilities.selectInventoryCategoryButton("Other")
    guiUtilities.showInventoryCategory("Other")
end)



updatePlayerGoldInventoryRemoteEvent.OnClientEvent:Connect(function(playerGold)
    playerUtilities.GetInventoryGoldTextLabel().Text = playerGold
end)


loadPlayerBackpackRemoteEvent.OnClientEvent:Connect(function(equipped)
    -- Load Backpack
    for _, v in ipairs(equipped) do
        local tool = tools[v]:Clone()
        tool.Parent = playerUtilities.GetLocalPlayer().Backpack
        
    end
end)


updateInventoryRemoteEvent.OnClientEvent:Connect(function()
    guiUtilities.removeItemsInventory()
    -- Load inventory
    local results = getPlayerInventoryRemoteFunc:InvokeServer()
    guiUtilities.addItemsInventory(results)
end)


removeToolFromPlayerRemoteEvent.OnClientEvent:Connect(function(tool)
    pcall(function()
        playerUtilities.removeToolFromPlayer(playerUtilities.GetLocalPlayer(), tool)
    end)
end)

removeAllToolsFromPlayer.OnClientEvent:Connect(function()
    playerUtilities.removeAllToolsFromPlayer(playerUtilities.GetLocalPlayer())
end)