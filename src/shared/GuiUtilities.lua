local module = {}



function module.getInventoryGui()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")
end


function module.getInventoryButtonGui()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryButtonGui")
end


function module.getInventoryButton()
    return module.getInventoryButtonGui().InventoryButton
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
    local dropItemRemoteEvent = ReplicatedStorage.RemoteEvents.DropItem
    local tools = ReplicatedStorage.Tools
    local player = playerUtilities.GetLocalPlayer()
    
    for k, _ in pairs(items) do

        if k == "weapons" then
            for weapon, v in items[k] do
                local inventoryFrame = ReplicatedStorage.GUI.InventoryFrame:Clone()
                inventoryFrame.ItemName.Text = weapon
                inventoryFrame.ItemCount.Text = v["count"]
    
                inventoryFrame.EquipButton.MouseButton1Click:Connect(function()

                    -- Fire event to add item to equipped in database
                    equipItemRemoteEvent:FireServer(weapon, "weapon")
                    inventoryFrame.UnequipButton.Visible = true
                    inventoryFrame.EquipButton.Visible = false
                end)

                inventoryFrame.UnequipButton.MouseButton1Click:Connect(function()

                    -- Remove from backback
                    playerUtilities.removeToolFromPlayer(player, weapon)
                    
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

                -- Drop button clicked
                inventoryFrame.DropButton.MouseButton1Click:Connect(function()

                    if inventoryFrame.DropFrame.Visible then
                        inventoryFrame.DropFrame.Visible = false
                    else
                        inventoryFrame.DropFrame.Visible = true
                    end

                end)

                -- Only numbers (0-9)
                inventoryFrame.DropFrame.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                    inventoryFrame.DropFrame.TextBox.Text = inventoryFrame.DropFrame.TextBox.Text:gsub('%D+', '');
                end)

                -- Drop Frame OK
                inventoryFrame.DropFrame.OkButton.MouseButton1Click:Connect(function()
                    local dropAmount = inventoryFrame.DropFrame.TextBox.Text
                    -- Fire event to server (database) to verify if can drop and drop it
                    dropItemRemoteEvent:FireServer(weapon, dropAmount)
                    inventoryFrame.DropFrame.Visible = false
                    inventoryFrame.DropFrame.TextBox.Text = ""
                end)

                -- Drop Frame NO
                inventoryFrame.DropFrame.NoButton.MouseButton1Click:Connect(function()
                    inventoryFrame.DropFrame.Visible = false
                    inventoryFrame.DropFrame.TextBox.Text = ""
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


function module.showBuyItemMessageSuccess()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BuyItemMessageSuccessGui")
    gui.Enabled = true
end


function module.hideBuyItemMessageSuccess()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BuyItemMessageSuccessGui")
    gui.Enabled = false
end


function module.showBuyItemMessageFailed()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BuyItemMessageFailedGui")
    gui.Enabled = true
end


function module.hideBuyItemMessageFailed()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BuyItemMessageFailedGui")
    gui.Enabled = false
end


function module.animateShopButton(button)
	local TweenService = game:GetService("TweenService") 

	local gradient = button.UIGradient
	local ti = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
	local offset1 = {Offset = Vector2.new(1, 0)}
	local create = TweenService:Create(gradient, ti, offset1)
	local startingPos = Vector2.new(-1, 0) --start on the right, tween to the left so it looks like the shine went from left to right
	local addWait = 1.5 --the amount of seconds between each couplet of shines

	create:Play()
	create.Completed:Wait()
	gradient.Offset = startingPos
	create:Play()
	create.Completed:Wait()
	gradient.Offset = startingPos
	task.wait(addWait)
	module.animateShopButton(button)
	
end

return module