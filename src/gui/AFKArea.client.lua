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

local getPlayerAfkAreaTimeRemoteFunc = ReplicatedStorage.RemoteFunctions.GetPlayerAFKAreaTime :: RemoteFunction

local afkAreaNum = 1

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

    local results = getPlayerAfkAreaTimeRemoteFunc:InvokeServer()
    task.wait(0.5)
    
    if results ~= 0 then
        
        if utilities.getIsWholeNumber(results / 60) then
            hours += results / 60
        
        else
            local stringTime = tostring(results / 60)
            local splitTime = stringTime:split(".")
            local newHours = splitTime[1]
            local newMin = splitTime[2]
            hours += tonumber(newHours)

            if newMin == "25" then
                minutes += 15
            elseif newMin == "5" then
                minutes += 30
            elseif newMin == "75" then
                minutes += 45
            end
           
        end
    end
    

    
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
        -- FIX this
        if (minutes ~= 0 and minutes % 15 == 0 and seconds == 0) or (hours ~= 0 and ((hours * 15) + minutes) % 15 == 0 and seconds == 0) then
            updateAfkAreaTimeRemoteEvent:FireServer(15)
            -- TODO: Show a GUI that player is teleporting to another AFK area
            task.wait(3)
            if afkAreaNum == 1 then
                teleportUtilities.teleportPlayerToAFKArea2(playerUtilities.GetLocalPlayer())
                break
            elseif afkAreaNum == 2 then
                teleportUtilities.teleportPlayerToAFKArea(playerUtilities.GetLocalPlayer())
                break
            end
        end

    end

end)


openAfkAreaRemoteEvent.OnClientEvent:Connect(function(num)
    -- set global variable tracking afk area
    afkAreaNum = num

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

