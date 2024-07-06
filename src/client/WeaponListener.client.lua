  -----------------------------
 -- SERVICES --
 -----------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")


-----------------------------
  -- VARIABLES --
 -----------------------------
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local weaponUtilities = require(ReplicatedStorage.Weapons)


local weaponEquippedRemoteEvent = ReplicatedStorage.RemoteEvents.WeaponEquipped :: RemoteEvent


 -----------------------------
-- FUNCTIONS --
 -----------------------------

 local function createTrack(animId)
    local player = playerUtilities.GetLocalPlayer()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid") :: Humanoid
    local animator = humanoid:WaitForChild("Animator")
    local animation = Instance.new("Animation")
    animation.AnimationId = animId
    return animator:LoadAnimation(animation)
 end


-----------------------------
-- EVENTS --
-----------------------------


-- Have remote event that fires when player equips to set every event up

weaponEquippedRemoteEvent.OnClientEvent:Connect(function(item)

    local tool = playerUtilities.getPlayerTool(item)

    tool.Activated:Connect(function()
        local swingTrack = createTrack(weaponUtilities.Weapons[item].Animations.Swing[1])
        swingTrack:Play()
    end)


    
    
end)