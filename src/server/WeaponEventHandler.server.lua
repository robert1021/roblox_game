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
    if player.Name ~= touchPart.Parent.Parent.Name then return end
    if swinging then return end
    swinging = true
    -- -- Play sounds
    -- print("playing sound...")

    local stop = false
    -- Spawn a thread to check for touching parts
    task.spawn(function()
        while not stop do
            local touchedParts = game.Workspace:GetPartsInPart(touchPart)
            for _, v in ipairs(touchedParts) do
                if v.Parent:FindFirstChildWhichIsA("Humanoid") then
                    local humanoid = v.Parent:FindFirstChildWhichIsA("Humanoid")
                    local humanoidCharacter = Players:GetPlayerFromCharacter(humanoid.Parent)
                    local humanoidName = nil
    
                    if humanoidCharacter ~= nil then
                        humanoidName = humanoidCharacter.Name
                    end
    
                    if humanoidName ~= player.Name then
                        humanoid:TakeDamage(weaponUtilities.Weapons[item].Damage)
                        stop = true
                        break
                        
                    end
                end
            end
            task.wait(0.1)
        end
    end)
    -- Wait for animation to stop - make this dynamic
    task.wait(0.4)
    stop = true
    
    task.wait(weaponUtilities.Weapons[item].Cooldown)
    swinging = false
end)