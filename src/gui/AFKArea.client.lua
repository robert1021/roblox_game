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
local closeAfkAreaRemoteEvent = ReplicatedStorage.RemoteEvents.CloseAFKArea :: RemoteEvent

-----------------------------
-- FUNCTIONS --
-----------------------------


-----------------------------
-- EVENTS --
-----------------------------

afkAreaButton.MouseButton1Click:Connect(function()
    afkAreaTimeLabel.Text = "00:00"
    afkAreaGoldEarnedLabel.Text = "0"
    afkAreaExpEarnedLabel.Text = "0"
    playerUtilities.DisablePlayerMovement(playerUtilities.GetLocalPlayer())
    afkGui.Enabled = true
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end)


afkAreaLeaveButton.MouseButton1Click:Connect(function()
    afkAreaTimeLabel.Text = "00:00"
    afkAreaGoldEarnedLabel.Text = "0"
    afkAreaExpEarnedLabel.Text = "0"
    playerUtilities.EnablePlayerMovement(playerUtilities.GetLocalPlayer())
    afkGui.Enabled = false
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
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

        -- Fire some sort of event to teleport player to same spot in afk area to get around being kicked
        -- should fire every 19 minutes or so - roblox kicks players at 20 min inactivity
        
    end


end)


closeAfkAreaRemoteEvent.OnClientEvent:Connect(function()
    playerUtilities.EnablePlayerMovement(playerUtilities.GetLocalPlayer())
    afkGui.Enabled = false
    afkAreaTimeLabel.Text = "00:00"
    afkAreaGoldEarnedLabel.Text = "0"
    afkAreaExpEarnedLabel.Text = "0"
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)

