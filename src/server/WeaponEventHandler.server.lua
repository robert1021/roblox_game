-----------------------------
-- SERVICES --
------------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")


-----------------------------
-- VARIABLES --
-----------------------------
local weaponUtilities = require(ReplicatedStorage.Weapons)

local weaponSwungRemoteEvent = ReplicatedStorage.RemoteEvents.WeaponSwung :: RemoteEvent



local swinging = false

-----------------------------
-- FUNCTIONS --
-----------------------------




-----------------------------
-- EVENTS --
-----------------------------

weaponSwungRemoteEvent.OnServerEvent:Connect(function(player, item, touchPart)
   
    if swinging then return end
    swinging = true
    -- Play sounds
    print("playing sound...")


    local touchConnection = touchPart.Touched:Connect(function(otherPart)
    
        if not swinging then return end

        local humanoid = otherPart.Parent:FindFirstChildWhichIsA("Humanoid")

        if not humanoid then return end

        if Players:GetPlayerFromCharacter(otherPart.Parent) then
            return
        end
        -- Damage the humanoid
        humanoid:TakeDamage(weaponUtilities.Weapons[item].Damage)
    
    end)
        
    task.wait(weaponUtilities.Weapons[item].Cooldown)
    touchConnection:Disconnect()
    swinging = false

end)