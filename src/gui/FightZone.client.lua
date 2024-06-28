local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local fightZoneRemoteEvent = ReplicatedStorage.FightZoneRemoteEvent
local readyButton = utility.GetFightZoneReadyButtonGui().TextButton :: TextButton
local unreadyButton = utility.GetFightZoneUnreadyButtonGui().TextButton :: TextButton
local player = playerUtilities.GetLocalPlayer()



-- Events

fightZoneRemoteEvent.OnClientEvent:Connect(function(part)
	
	-- Show shop button on local player's screen
	utility.ToggleFightZoneReadyButtonGui()
end)

readyButton.MouseButton1Click:Connect(function()
    playerUtilities.DisablePlayerMovement(player)
    utility.ToggleFightZoneReadyButtonGui()
    utility.ToggleFightZoneUnreadyButtonGui()
end)

unreadyButton.MouseButton1Click:Connect(function()
    utility.ToggleFightZoneUnreadyButtonGui()
    utility.ToggleFightZoneReadyButtonGui()
    playerUtilities.EnablePlayerMovement(player)
end)


