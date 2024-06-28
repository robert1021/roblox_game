local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local fightZoneUtilities = require(ReplicatedStorage.FightZoneUtilities)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local fightZoneFFA1RemoteEvent = ReplicatedStorage.FightZoneFFA1RemoteEvent
local fightZoneFFA1ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA1ReadyRemoteEvent
local fightZoneFFA1UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA1UnreadyRemoteEvent
local fightZoneFFA1ReadyButton = fightZoneUtilities.GetFightZoneFFA1ReadyButtonGui().TextButton :: TextButton
local fightZoneFFA1UnreadyButton = fightZoneUtilities.GetFightZoneFFA1UnreadyButtonGui().TextButton :: TextButton
local player = playerUtilities.GetLocalPlayer()



-- Events

fightZoneFFA1RemoteEvent.OnClientEvent:Connect(function(part)
	
	-- Show shop button on local player's screen
	fightZoneUtilities.ToggleFightZoneFFA1ReadyButtonGui()
end)

fightZoneFFA1ReadyButton.MouseButton1Click:Connect(function()
    playerUtilities.DisablePlayerMovement(player)
    fightZoneUtilities.ToggleFightZoneFFA1ReadyButtonGui()
    fightZoneFFA1ReadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA1UnreadyButtonGui()
end)

fightZoneFFA1UnreadyButton.MouseButton1Click:Connect(function()
    fightZoneUtilities.ToggleFightZoneFFA1UnreadyButtonGui()
    fightZoneFFA1UnreadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA1ReadyButtonGui()
    playerUtilities.EnablePlayerMovement(player)
end)


