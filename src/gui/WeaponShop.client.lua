local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local weapons = require(ReplicatedStorage.Weapons)
local utility = require(ReplicatedStorage.UtilityModuleScript)
local guiUtilities = require(ReplicatedStorage.GuiUtilities)
local soundUtilities = require(ReplicatedStorage.SoundUtilities)

local inventoryGui = guiUtilities.getInventoryGui()
local inventoryButtonGui = guiUtilities.getInventoryButtonGui()

local weaponShopButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopButtonGui").ShopButton
local weaponShopCloseButton = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopGui").Frame.CloseButton
local scrollingFrame = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponShopGui").Frame.ScrollingFrame :: ScrollingFrame
local buyWeaponRemoteEvent = ReplicatedStorage.RemoteEvents.BuyWeaponRemoteEvent :: RemoteEvent
local buyItemMessageSuccess = ReplicatedStorage.RemoteEvents.BuyItemMessageSuccess :: RemoteEvent
local buyItemMessageFailed = ReplicatedStorage.RemoteEvents.BuyItemMessageFailed :: RemoteEvent

-- Events

-- Weapon Shop --

weaponShopButton.MouseButton1Click:Connect(function()
	-- close inventory and hide button
	inventoryGui.Enabled = false
	inventoryButtonGui.Enabled = false

	-- Load weapons
	for k, v in pairs(weapons.getWeapons()) do
		local frame = ReplicatedStorage.GUI.ShopItemFrame:Clone()
		frame.Parent = scrollingFrame
		frame.ItemName.Text = k
		frame.GoldAmount.Text = tostring(weapons.getWeaponPrice(k))

		frame.BuyButton.MouseButton1Click:Connect(function()
			-- Use remote function to add item to players inventory in database
			buyWeaponRemoteEvent:FireServer(k)
		end)

	end

	utility.ToggleWeaponShop()
end)

weaponShopCloseButton.MouseButton1Click:Connect(function()
	-- Enable inventory when shop closed
	inventoryButtonGui.Enabled = true
	-- Hide the message gui's
	guiUtilities.hideBuyItemMessageSuccess()
	guiUtilities.hideBuyItemMessageFailed()

	for _, v in scrollingFrame:GetChildren() do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end

	utility.ToggleWeaponShop()
end)


buyItemMessageSuccess.OnClientEvent:Connect(function()
	-- TODO: play button sound
	soundUtilities.playBuyItemSuccessSound()
	guiUtilities.showBuyItemMessageSuccess()
	
end)


buyItemMessageFailed.OnClientEvent:Connect(function()
	-- TODO: play button sound
	soundUtilities.playBuyItemFailedSound()
	guiUtilities.showBuyItemMessageFailed()

end)


RunService.RenderStepped:Connect(function()
	for i, v in scrollingFrame:GetChildren() do
		if v:IsA("Frame") then
			v.UIStroke.UIGradient.Rotation += 2
		end
	end
end)



guiUtilities.animateShopButton(weaponShopButton)