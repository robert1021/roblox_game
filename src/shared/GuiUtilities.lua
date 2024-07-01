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
    local tools = ReplicatedStorage.Tools
    
    for k, _ in pairs(items) do

        if k == "weapons" then
            for weapon, v in items[k] do
                local inventoryFrame = ReplicatedStorage.GUI.InventoryFrame:Clone()
                inventoryFrame.ItemName.Text = weapon
                inventoryFrame.ItemCount.Text = v["count"]
    
                inventoryFrame.EquipButton.MouseButton1Click:Connect(function()
                    
                    for _, child in tools:GetChildren() do
                        if child.Name == weapon then
                            local tool = child:Clone()
                            tool.Parent = playerUtilities.GetLocalPlayer().Backpack
                            break
                        end
                    end

                    -- Fire event to add item to equipped in database
                    equipItemRemoteEvent:FireServer(weapon)
                    inventoryFrame.UnequipButton.Visible = true
                    inventoryFrame.EquipButton.Visible = false
                end)

                inventoryFrame.UnequipButton.MouseButton1Click:Connect(function()

                    -- Remove from backback
                    
                    if playerUtilities.getIsToolInBackpack(weapon) then
                        playerUtilities.removeToolBackpack(weapon)
                    else
                        local name = playerUtilities.GetLocalPlayer().Name
                        game.Workspace[name][weapon]:Destroy()
                    end
                    
                    -- Fire event remove item from equipped in database
                    unequipItemRemoteEvent:FireServer(weapon)

                    inventoryFrame.EquipButton.Visible = true
                    inventoryFrame.UnequipButton.Visible = false

                end)
                
                -- Check if item is equipped and change the button
                if v["equipped"] then
                    inventoryFrame.UnequipButton.Visible = true
                    inventoryFrame.EquipButton.Visible = false
                else
                    inventoryFrame.UnequipButton.Visible = false
                    inventoryFrame.EquipButton.Visible = true
                end

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


function module.selectInventoryCategoryButton(category)

    if category == "Weapons" then
        module.getInventoryWeaponsButton().UIStroke.Enabled = true
        module.getInventoryArmorButton().UIStroke.Enabled = false
        module.getInventoryPotionsButton().UIStroke.Enabled = false
        module.getInventoryOtherButton().UIStroke.Enabled = false
    elseif category =="Armor" then
        module.getInventoryWeaponsButton().UIStroke.Enabled = false
        module.getInventoryArmorButton().UIStroke.Enabled = true
        module.getInventoryPotionsButton().UIStroke.Enabled = false
        module.getInventoryOtherButton().UIStroke.Enabled = false
    elseif category =="Potions" then
        module.getInventoryWeaponsButton().UIStroke.Enabled = false
        module.getInventoryArmorButton().UIStroke.Enabled = false
        module.getInventoryPotionsButton().UIStroke.Enabled = true
        module.getInventoryOtherButton().UIStroke.Enabled = false
    elseif category =="Other" then
        module.getInventoryWeaponsButton().UIStroke.Enabled = false
        module.getInventoryArmorButton().UIStroke.Enabled = false
        module.getInventoryPotionsButton().UIStroke.Enabled = false
        module.getInventoryOtherButton().UIStroke.Enabled = true
    end
end



return module