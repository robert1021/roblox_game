local module = {
    ["levels"] = {
        [1] = 0,
        [2] = 100,
        [3] = 300,
        [4] = 600,
        [5] = 1000,
        [6] = 1500,
        [7] = 2100,
        [8] = 2800,
        [9] = 3600,
        [10] = 4500,
        [11] = 5500,
        [12] = 6600,
        [13] = 7800,
        [14] = 9100,
        [15] = 10500,
        [16] = 12000,
        [17] = 13600,
        [18] = 15300,
        [19] = 17100,
        [20] = 19000,
        [21] = 21000,
        [22] = 23100,
        [23] = 25300,
        [24] = 27600,
        [25] = 30000,
        [26] = 32500,
        [27] = 35100,
        [28] = 37800,
        [29] = 40600,
        [30] = 43500,
        [31] = 46500,
        [32] = 49600,
        [33] = 52800,
        [34] = 56100,
        [35] = 59500,
        [36] = 63000,
        [37] = 66600,
        [38] = 70300,
        [39] = 74100,
        [40] = 78000,
        [41] = 85000,
        [42] = 92500,
        [43] = 100500,
        [44] = 109000,
        [45] = 118000,
        [46] = 127500,
        [47] = 137500,
        [48] = 148000,
        [49] = 159000,
        [50] = 170500,
        [51] = 182500,
        [52] = 195000,
        [53] = 208000,
        [54] = 221500,
        [55] = 235500,
        [56] = 250000,
        [57] = 265000,
        [58] = 280500,
        [59] = 296500,
        [60] = 313000,
        [61] = 330000,
        [62] = 347500,
        [63] = 365500,
        [64] = 384000,
        [65] = 403000,
        [66] = 422500,
        [67] = 442500,
        [68] = 463000,
        [69] = 484000,
        [70] = 505500,
        [71] = 527500,
        [72] = 550000,
        [73] = 573000,
        [74] = 596500,
        [75] = 620500,
        [76] = 645000,
        [77] = 670000,
        [78] = 695500,
        [79] = 721500,
        [80] = 748000,
        [81] = 775000,
        [82] = 802500,
        [83] = 830500,
        [84] = 859000,
        [85] = 888000,
        [86] = 917500,
        [87] = 947500,
        [88] = 978000,
        [89] = 1009000,
        [90] = 1041000,
        [91] = 1073500,
        [92] = 1106500,
        [93] = 1140000,
        [94] = 1174000,
        [95] = 1208500,
        [96] = 1243500,
        [97] = 1279000,
        [98] = 1315000,
        [99] = 1351500,
        [100] = 1388500
    },
    
}

function module.GetExpRequiredForLevel(level)
    return module[level]
end

function module.CalculateCurrentLevelWithExp(exp)
    local currentIndex = 0
    for i, v in pairs(module.levels) do
        currentIndex += 1

        if exp > module["levels"][100] then
            return 100
        elseif exp == v then
            return i
        elseif exp > v then
            continue
        elseif exp < v then
            return i - 1
        end
    end

end

function module.CalculatePercentLevelComplete(playerLevel, playerExp)
    local expCurrentLevelReq = module["levels"][playerLevel]
    local nextLevel = playerLevel + 1
    local expNextLevelReq = module["levels"][nextLevel]

    return (playerExp - expCurrentLevelReq)  / (expNextLevelReq - expCurrentLevelReq) * 100
end

return module