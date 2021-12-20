local Players: Players = game:GetService("Players")
local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Portal = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Portal"))
Portal = Portal.new()

local Subscriptions = require(ReplicatedStorage:WaitForChild("portal.subscriptions"))

local PlayerJoined = Subscriptions.Client.PlayerJoined

local joinedSubscriber = Portal:Subscribe(PlayerJoined)

Portal:Publish("Client", "Loaded", { Ping = "Pong!" })

Players.PlayerAdded:Connect(function(player)
	if #Players:GetPlayers() == 2 then
		joinedSubscriber()
	end
	print("No notification for:", player)
end)
