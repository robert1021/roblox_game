local module = {}



function module.getInventoryGui()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")
end


function module.getInventoryWeaponsButton()
    return module.getInventoryGui().Frame.ButtonFrame.WeaponsButton
end


function module.getInventoryArmorButton()
    return module.getInventoryGui().Frame.ButtonFrame.ArmorButton
end


function module.getInventoryPotionsButton()
    return module.getInventoryGui().Frame.ButtonFrame.PotionsButton
end


function module.getInventoryOtherButton()
    return module.getInventoryGui().Frame.ButtonFrame.OtherButton
end

function module.addItemsInventory(items)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local weapons = require(ReplicatedStorage.Weapons)
    local utility = require(ReplicatedStorage.UtilityModuleScript)
    local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
    local inventory = module.getInventoryGui()
    local equipItemRemoteEvent = ReplicatedStorage.RemoteEvents.EquipItem
    local unequipItemRemoteEvent = ReplicatedStorage.RemoteEvents.UnequipItem
    local getPlayerEquippedRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerEquipped :: RemoteFunction
    local tools = ReplicatedStorage.Tools

    local equippedResults = getPlayerEquippedRemoteFunc:InvokeServer()
    print(equippedResults)

    for k, _ in pairs(items) do

        if k == "weapons" then
            for _, item in items[k] do
                local inventoryFrame = ReplicatedStorage.GUI.InventoryFrame:Clone()
                inventoryFrame.ItemName.Text = item
    
                inventoryFrame.EquipButton.MouseButton1Click:Connect(function()
                    
                    for _, child in tools:GetChildren() do
                        if child.Name == item then
                            local tool = child:Clone()
                            tool.Parent = playerUtilities.GetLocalPlayer().Backpack
                            break
                        end
                    end

                    -- Fire event to add item to equipped in database
                    equipItemRemoteEvent:FireServer(item)
                    inventoryFrame.UnequipButton.Visible = true
                    inventoryFrame.EquipButton.Visible = false
                end)

                inventoryFrame.UnequipButton.MouseButton1Click:Connect(function()

                    -- Remove from backback
                    
                    if playerUtilities.getIsToolInBackpack(item) then
                        playerUtilities.removeToolBackpack(item)
                    else
                        local name = playerUtilities.GetLocalPlayer().Name
                        game.Workspace[name][item]:Destroy()
                    end
                    
                    -- Fire event remove item from equipped in database
                    unequipItemRemoteEvent:FireServer(item)

                    inventoryFrame.EquipButton.Visible = true
                    inventoryFrame.UnequipButton.Visible = false

                end)
                
                -- Check if item is equipped and change the button
                -- if utility.GetIndexOfTableValue(equippedResults, item) ~= nil then
                --     inventoryFrame.UnequipButton.Visible = true
                --     inventoryFrame.EquipButton.Visible = false
                -- end

                inventoryFrame.Parent = inventory.Frame.WeaponsScrollingFrame
            end
        end

    end
end


function module.removeItemsInventory()
    local inventory = module.getInventoryGui()

    for _, child in inventory.Frame:GetChildren() do
        if child:IsA("ScrollingFrame") then
            for _, scrollingFrameChild in child:GetChildren() do
                if scrollingFrameChild:IsA("Frame") then
                    scrollingFrameChild:Destroy()
                end
            end
        end

    end
end

function module.showInventoryCategory(category)
    local inventory = module.getInventoryGui()
    
    for _, child in inventory.Frame:GetChildren() do
        if child:IsA("ScrollingFrame") then
            if string.find(child.Name, category) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end

end



return module