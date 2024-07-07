module = {
    ["Weapons"] = {
        ["Hammer"] = {
            ["Price"] = 100,
            ["Damage"] = 10,
            ["Cooldown"] = 0.5,
            ["Animations"] = {
                ["Swing"] = {
                    "rbxassetid://18349571763"
                },
            },
            ["Sounds"] = {
                ["Equip"] = {},
                ["Unequip"] = {},
                ["Swing"] = {},
                
            },
            ["AnimationSpeed"] = 1.5,
        },
        ["Sword"] = {
            ["Price"] = 100,
            ["Damage"] = 10,
        },
        ["Spear"] = {
            ["Price"] = 150,
            ["Damage"] = 15,
        },
        ["Trident"] = {
            ["Price"] = 250,
            ["Damage"] = 20,
        },
    },
    
}

function module.getWeapons()
    return module["Weapons"]
end

function module.getWeaponPrice(key)
    return module.getWeapons()[key]["Price"]
end


function module.getWeaponDamage(key)
    return module.getWeapons()[key]["Damage"]
end

return module