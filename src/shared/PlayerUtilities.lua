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






return module