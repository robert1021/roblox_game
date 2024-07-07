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
local weaponSwungRemoteEvent = ReplicatedStorage.RemoteEvents.WeaponSwung :: RemoteEvent

local swingDebounce = false


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
    local touchPart = tool.Touch
    local equipSound = Instance.new("Sound")
    equipSound.Playing = false
    equipSound.SoundId = weaponUtilities.Weapons[item].Sounds.Equip
    equipSound.Volume = 0.2
    equipSound.Parent = tool

    tool.Equipped:Connect(function()
      print("equipped")
      equipSound:Play()
    end)
  
    tool.Unequipped:Connect(function()
      print("Unequipped")
    end)

    tool.Activated:Connect(function()

      if swingDebounce then return end

      swingDebounce = true
      local swingTrack = createTrack(weaponUtilities.Weapons[item].Animations.Swing[1])
      swingTrack:Play()
      swingTrack:AdjustSpeed(weaponUtilities.Weapons[item].AnimationSpeed)
      weaponSwungRemoteEvent:FireServer(item, touchPart)
      swingTrack.Ended:Wait()
      swingTrack:Destroy()
      task.wait(weaponUtilities.Weapons[item].Cooldown)
      swingDebounce = false

    end)


end)