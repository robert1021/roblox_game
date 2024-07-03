local module = {}





function module.getBuyItemSuccessSound()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    return ReplicatedStorage.Sounds.MoneyPickup
end


function module.playBuyItemSuccessSound()
    module.getBuyItemSuccessSound():Play()
end


function module.getBuyItemFailedSound()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    return ReplicatedStorage.Sounds.Error
end


function module.playBuyItemFailedSound()
    module.getBuyItemFailedSound():Play()
end







return module