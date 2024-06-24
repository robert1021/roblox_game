local ReplicatedStorage = game:GetService("ReplicatedStorage")
local expTable = require(ReplicatedStorage.ExpTable)

local level = expTable.CalculateCurrentLevelWithExp(100)

print("level" .. tostring(level))