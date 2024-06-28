local ReplicatedStorage = game:GetService("ReplicatedStorage")


local utility = require(ReplicatedStorage.UtilityModuleScript)
local fightZoneUtilities = require(ReplicatedStorage.FightZoneUtilities)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local player = playerUtilities.GetLocalPlayer()

local fightZoneFFA1RemoteEvent = ReplicatedStorage.FightZoneFFA1RemoteEvent
local fightZoneFFA1ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA1ReadyRemoteEvent
local fightZoneFFA1UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA1UnreadyRemoteEvent
local fightZoneFFA1ReadyButton = fightZoneUtilities.GetFightZoneFFA1ReadyButtonGui().TextButton :: TextButton
local fightZoneFFA1UnreadyButton = fightZoneUtilities.GetFightZoneFFA1UnreadyButtonGui().TextButton :: TextButton

local fightZoneFFA2RemoteEvent = ReplicatedStorage.FightZoneFFA2RemoteEvent
local fightZoneFFA2ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA2ReadyRemoteEvent
local fightZoneFFA2UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA2UnreadyRemoteEvent
local fightZoneFFA2ReadyButton = fightZoneUtilities.GetFightZoneFFA2ReadyButtonGui().TextButton :: TextButton
local fightZoneFFA2UnreadyButton = fightZoneUtilities.GetFightZoneFFA2UnreadyButtonGui().TextButton :: TextButton

local fightZoneFFA3RemoteEvent = ReplicatedStorage.FightZoneFFA3RemoteEvent
local fightZoneFFA3ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA3ReadyRemoteEvent
local fightZoneFFA3UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA3UnreadyRemoteEvent
local fightZoneFFA3ReadyButton = fightZoneUtilities.GetFightZoneFFA3ReadyButtonGui().TextButton :: TextButton
local fightZoneFFA3UnreadyButton = fightZoneUtilities.GetFightZoneFFA3UnreadyButtonGui().TextButton :: TextButton

local fightZoneFFA4RemoteEvent = ReplicatedStorage.FightZoneFFA4RemoteEvent
local fightZoneFFA4ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA4ReadyRemoteEvent
local fightZoneFFA4UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA4UnreadyRemoteEvent
local fightZoneFFA4ReadyButton = fightZoneUtilities.GetFightZoneFFA4ReadyButtonGui().TextButton :: TextButton
local fightZoneFFA4UnreadyButton = fightZoneUtilities.GetFightZoneFFA4UnreadyButtonGui().TextButton :: TextButton



-- Events


-- FFA Fight Zone 1

fightZoneFFA1RemoteEvent.OnClientEvent:Connect(function(part)
	
	-- Show shop button on local player's screen
	fightZoneUtilities.ToggleFightZoneFFA1ReadyButtonGui()
end)

fightZoneFFA1ReadyButton.MouseButton1Click:Connect(function()
    playerUtilities.DisablePlayerMovement(player)
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA1Model(), Enum.Material.Neon)
    fightZoneUtilities.ToggleFightZoneFFA1ReadyButtonGui()
    fightZoneFFA1ReadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA1UnreadyButtonGui()
end)

fightZoneFFA1UnreadyButton.MouseButton1Click:Connect(function()
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA1Model(), Enum.Material.Plastic)
    fightZoneUtilities.ToggleFightZoneFFA1UnreadyButtonGui()
    fightZoneFFA1UnreadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA1ReadyButtonGui()
    playerUtilities.EnablePlayerMovement(player)
end)


-- FFA Fight Zone 2

fightZoneFFA2RemoteEvent.OnClientEvent:Connect(function(part)
	
	-- Show shop button on local player's screen
	fightZoneUtilities.ToggleFightZoneFFA2ReadyButtonGui()
end)

fightZoneFFA2ReadyButton.MouseButton1Click:Connect(function()
    playerUtilities.DisablePlayerMovement(player)
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA2Model(), Enum.Material.Neon)
    fightZoneUtilities.ToggleFightZoneFFA2ReadyButtonGui()
    fightZoneFFA2ReadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA2UnreadyButtonGui()
end)

fightZoneFFA2UnreadyButton.MouseButton1Click:Connect(function()
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA2Model(), Enum.Material.Plastic)
    fightZoneUtilities.ToggleFightZoneFFA2UnreadyButtonGui()
    fightZoneFFA2UnreadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA2ReadyButtonGui()
    playerUtilities.EnablePlayerMovement(player)
end)


-- FFA Fight Zone 3

fightZoneFFA3RemoteEvent.OnClientEvent:Connect(function(part)
	
	-- Show shop button on local player's screen
	fightZoneUtilities.ToggleFightZoneFFA3ReadyButtonGui()
end)

fightZoneFFA3ReadyButton.MouseButton1Click:Connect(function()
    playerUtilities.DisablePlayerMovement(player)
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA3Model(), Enum.Material.Neon)
    fightZoneUtilities.ToggleFightZoneFFA3ReadyButtonGui()
    fightZoneFFA3ReadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA3UnreadyButtonGui()
end)

fightZoneFFA3UnreadyButton.MouseButton1Click:Connect(function()
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA3Model(), Enum.Material.Plastic)
    fightZoneUtilities.ToggleFightZoneFFA3UnreadyButtonGui()
    fightZoneFFA3UnreadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA3ReadyButtonGui()
    playerUtilities.EnablePlayerMovement(player)
end)


-- FFA Fight Zone 4

fightZoneFFA4RemoteEvent.OnClientEvent:Connect(function(part)
	
	-- Show shop button on local player's screen
	fightZoneUtilities.ToggleFightZoneFFA4ReadyButtonGui()
end)

fightZoneFFA4ReadyButton.MouseButton1Click:Connect(function()
    playerUtilities.DisablePlayerMovement(player)
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA4Model(), Enum.Material.Neon)
    fightZoneUtilities.ToggleFightZoneFFA4ReadyButtonGui()
    fightZoneFFA4ReadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA4UnreadyButtonGui()
end)

fightZoneFFA4UnreadyButton.MouseButton1Click:Connect(function()
    fightZoneUtilities.ChangeFightZoneBaseMaterial(fightZoneUtilities.GetFightZoneFFA4Model(), Enum.Material.Plastic)
    fightZoneUtilities.ToggleFightZoneFFA4UnreadyButtonGui()
    fightZoneFFA4UnreadyRemoteEvent:FireServer()
    fightZoneUtilities.ToggleFightZoneFFA4ReadyButtonGui()
    playerUtilities.EnablePlayerMovement(player)
end)


