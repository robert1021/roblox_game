local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local player = playerUtilities.GetLocalPlayer()
local humanoid = playerUtilities.GetHumanoidFromPlayer(player)
local healthGui = player.PlayerGui:FindFirstChild("HealthGui")
local healthFrame = healthGui.HealthFrame
local healthBar = healthFrame.HealthBar
local percentageText = healthFrame.Percentage


local function updateHealth()
    local size = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
    healthBar.Size = UDim2.new(size, 0, 1, 0)
    percentageText.Text = tostring(math.floor(size * 100)) .. "%"
end


-- Events
humanoid:GetPropertyChangedSignal("Health"):Connect(updateHealth)
humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateHealth)


updateHealth()