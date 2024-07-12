-----------------------------
-- SERVICES --
------------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")


-----------------------------
-- VARIABLES --
-----------------------------
local utilities = require(ReplicatedStorage.UtilityModuleScript)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)
local soundUtilities = require(ReplicatedStorage.SoundUtilities)
local afkUtilities = require(ReplicatedStorage.AfkUtilities)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local teleportUtilities = require(ReplicatedStorage.TeleportUtilities)


local afkGui = guiUtilities.getAFKGui()
local afkAreaButton = guiUtilities.getAFKAreaButton()
local afkAreaLeaveButton = guiUtilities.getAfkAreaLeaveButton()
local afkAreaTimeLabel = guiUtilities.getAfkAreaTimeLabel()
local afkAreaGoldEarnedLabel = guiUtilities.getAfkAreaGoldEarnedLabel()
local afkAreaExpEarnedLabel = guiUtilities.getAfkAreaExpEarnedLabel()

local sound = soundUtilities.createSound(afkGui, afkUtilities.Sounds.Reward, 0.5)

local addExpRemoteEvent = ReplicatedStorage.AddExpRemoteEvent :: RemoteEvent
local addPlayerGoldRemoteEvent = ReplicatedStorage.AddPlayerGoldRemoteEvent :: RemoteEvent
local openAfkAreaRemoteEvent = ReplicatedStorage.RemoteEvents.OpenAFKArea :: RemoteEvent
local closeAfkAreaRemoteEvent = ReplicatedStorage.RemoteEvents.CloseAFKArea :: RemoteEvent
local resetAfkAreaTimeRemoteEvent = ReplicatedStorage.RemoteEvents.ResetAFKAreaTime :: RemoteEvent
local updateAfkAreaTimeRemoteEvent = ReplicatedStorage.RemoteEvents.UpdateAFKAreaTime :: RemoteEvent

local afkAreaNum = 1
local totalMinutes = 0

-----------------------------
-- FUNCTIONS --
-----------------------------


-----------------------------
-- EVENTS --
-----------------------------

afkAreaButton.MouseButton1Click:Connect(function()
    -- afkAreaTimeLabel.Text = "00:00"
    -- afkAreaGoldEarnedLabel.Text = "0"
    -- afkAreaExpEarnedLabel.Text = "0"
    -- playerUtilities.DisablePlayerMovement(playerUtilities.GetLocalPlayer())
    -- afkGui.Enabled = true
    -- StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    resetAfkAreaTimeRemoteEvent:FireServer()
    playerUtilities.DisablePlayerMovement(playerUtilities.GetLocalPlayer())
    teleportUtilities.teleportPlayerToAFKArea()
end)


afkAreaLeaveButton.MouseButton1Click:Connect(function()
    -- afkAreaTimeLabel.Text = "00:00"
    -- afkAreaGoldEarnedLabel.Text = "0"
    -- afkAreaExpEarnedLabel.Text = "0"
    resetAfkAreaTimeRemoteEvent:FireServer()
    playerUtilities.EnablePlayerMovement(playerUtilities.GetLocalPlayer())
    -- afkGui.Enabled = false
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    teleportUtilities.TeleportPlayerToTownArea(playerUtilities.GetLocalPlayer())
end)


afkGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    local hours = 0
    local minutes = 0
    local seconds = 0
    local rewardPlayer = false

    while afkGui.Enabled do
        task.wait(1)
        seconds += 1
        rewardPlayer = false

        if seconds == 60 then
            seconds = 0
            minutes += 1
            rewardPlayer = true
        end

        if minutes == 60 then
            minutes = 0
            hours += 1
        end

        -- format
        local minutesFormatted = ""
        local secondsFormatted = ""

        if seconds < 10 then
            secondsFormatted = "0" .. tostring(seconds)
        else
            secondsFormatted = tostring(seconds)
        end

        if minutes < 10 then
            minutesFormatted = "0" .. tostring(minutes)
        else
            minutesFormatted = tostring(minutes)
        end


        if hours > 0 then
            afkAreaTimeLabel.Text = tostring(hours) .. ":" .. minutesFormatted .. ":" .. secondsFormatted
        else
            afkAreaTimeLabel.Text = minutesFormatted .. ":" .. secondsFormatted
        end

        -- TODO: Gain gold and exp
        if rewardPlayer then
            sound:Play()
            afkAreaGoldEarnedLabel.Text = tonumber(afkAreaGoldEarnedLabel.Text) + 5
            afkAreaExpEarnedLabel.Text = tonumber(afkAreaExpEarnedLabel.Text) + 25

            addPlayerGoldRemoteEvent:FireServer(5)
            addExpRemoteEvent:FireServer(25)
        end

        -- TODO:
        -- Fire some sort of event to teleport player to same spot in afk area to get around being kicked
        -- Fire every 15 minutes or so - roblox kicks players at 20 min inactivity

        if minutes == 15 then
            updateAfkAreaTimeRemoteEvent:FireServer(15)
            if afkAreaNum == 1 then
                teleportUtilities.teleportPlayerToAFKArea2(playerUtilities.GetLocalPlayer())
            elseif afkAreaNum == 2 then
                teleportUtilities.teleportPlayerToAFKArea(playerUtilities.GetLocalPlayer())
            end
        end

    end

end)


openAfkAreaRemoteEvent.OnClientEvent:Connect(function(num, minutes)
    -- set global variable tracking afk area
    afkAreaNum = num
    totalMinutes = minutes
    print(totalMinutes)

    afkAreaTimeLabel.Text = "00:00"
    afkAreaGoldEarnedLabel.Text = "0"
    afkAreaExpEarnedLabel.Text = "0"
    playerUtilities.DisablePlayerMovement(playerUtilities.GetLocalPlayer())
    afkGui.Enabled = true
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end)


closeAfkAreaRemoteEvent.OnClientEvent:Connect(function()
    resetAfkAreaTimeRemoteEvent:FireServer()
    playerUtilities.EnablePlayerMovement(playerUtilities.GetLocalPlayer())
    afkGui.Enabled = false
    afkAreaTimeLabel.Text = "00:00"
    afkAreaGoldEarnedLabel.Text = "0"
    afkAreaExpEarnedLabel.Text = "0"
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)

