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
    wait(0.1)
    humanoid.RootPart.Anchored = false
    wait(0.1)
    humanoid.RootPart.Anchored = true
end

function module.GetLocalPlayer()
    return game.Players.LocalPlayer
end






return module