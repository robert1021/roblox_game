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


local afkGui = guiUtilities.getAFKGui()
local afkAreaButton = guiUtilities.getAFKAreaButton()
local afkAreaLeaveButton = guiUtilities.getAfkAreaLeaveButton()
local afkAreaTimeLabel = guiUtilities.getAfkAreaTimeLabel()

-----------------------------
-- FUNCTIONS --
-----------------------------


-----------------------------
-- EVENTS --
-----------------------------

afkAreaButton.MouseButton1Click:Connect(function()
    afkAreaTimeLabel.Text = "00:00"
    afkGui.Enabled = true
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

    

end)


afkAreaLeaveButton.MouseButton1Click:Connect(function()
    afkAreaTimeLabel.Text = "00:00"
    afkGui.Enabled = false
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
end)


afkGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    local hours = 0
    local minutes = 0
    local seconds = 0

    while afkGui.Enabled do
        task.wait(1)
        seconds += 1

        if seconds == 60 then
            seconds = 0
            minutes += 1
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

        print("Gained gold")
        -- TODO: Gain gold
        
    end


end)

