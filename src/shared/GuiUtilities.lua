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
    local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
    local inventory = module.getInventoryGui()
    local tools = ReplicatedStorage.Tools


    for k, _ in pairs(items) do

        if k == "weapons" then
            for _, item in items[k] do
                local inventoryFrame = ReplicatedStorage.GUI.InventoryFrame:Clone()
                inventoryFrame.ItemName.Text = item
                inventoryFrame.Damage.Text = weapons.getWeaponDamage(item)

                inventoryFrame.EquipButton.MouseButton1Click:Connect(function()
                    
                    for _, child in tools:GetChildren() do
                        if child.Name == item then
                            local tool = child:Clone()
                            tool.Parent = playerUtilities.GetLocalPlayer().Backpack
                            break
                        end
                    end

                
                end)

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