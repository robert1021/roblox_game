local module = {

}

function module.GetHumanoidFromPlayer(player)
    return player.Character:FindFirstChild("Humanoid")
end


function module.DisablePlayerMovement(player)
    local humanoid = module.GetHumanoidFromPlayer(player)
    
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.RootPart.Anchored = true
    task.wait(0.1)
    humanoid.RootPart.Anchored = false
    task.wait(0.1)
    humanoid.RootPart.Anchored = true
end


function module.EnablePlayerMovement(player)
    local humanoid = module.GetHumanoidFromPlayer(player)
    
    humanoid.WalkSpeed = 16
    humanoid.RootPart.Anchored = false
end

function module.GetLocalPlayer()
    return game.Players.LocalPlayer
end

function module.GetInventoryGui()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")
end

function module.GetInventoryGoldTextLabel()
    local inventoryGui = module.GetInventoryGui()
    return inventoryGui.Frame.GoldFrame.Amount
end


function module.getIsToolInBackpack(player, tool)

    for _, child in player.Backpack:GetChildren() do
        if child.Name == tool then return true end
    end

    return false
end


function module.removeToolBackpack(player, tool)
    player.Backpack[tool]:Destroy()
end


function module.dropToolBackpack(player, tool)
    player.Backpack[tool].Parent = game.Workspace
end


function module.removeToolFromPlayer(player, tool)

    if module.getIsToolInBackpack(player, tool) then
        module.removeToolBackpack(player, tool)
    else
        local name = player.Name
        game.Workspace[name][tool]:Destroy()
    end

end


function module.removeAllToolsFromPlayer(player)
    local name = player.Name
    for _, child in player.Backpack:GetChildren() do
        print(child)
        child:Destroy()
    end

end



-- function module.dropToolFromPlayer(player, tool)

--     if module.getIsToolInBackpack(player, tool) then
--         module.dropToolBackpack(player, tool)
--     else
--         local name = player.Name
--         game.Workspace[name][tool].Parent = game.Workspace
--     end

-- end






return module