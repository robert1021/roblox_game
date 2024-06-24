local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local player = playerUtilities.GetLocalPlayer()
local humanoid = playerUtilities.GetHumanoidFromPlayer(player)
local expGui = player.PlayerGui:FindFirstChild("ExpGui")
local expFrame = expGui.ExpFrame
local expBar = expFrame.ExpBar
local levelText = expFrame.Level
local levelUpRemoteEvent = ReplicatedStorage.LevelUpRemoteEvent
local setLevelRemoteEvent = ReplicatedStorage.SetLevelRemoteEvent

-- Events



-- Listen for event from database handler

setLevelRemoteEvent.OnClientEvent:Connect(function(level)
    levelText.Text = "Level " .. level
end)

levelUpRemoteEvent.OnClientEvent:Connect(function(level)
    levelText.Text = "Level " .. level
    -- Do some fancy things on screen
end)


-- kill enemy and gain exp
-- from another script that handles this send the exp to the database
-- calculate if enough exp for level up
-- if yes fireClient top trigger level up in this script


