local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService: ServerScriptService = game:GetService("ServerScriptService")

local Portal = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Portal"))
Portal = Portal.new()

local Contexts = require(ServerScriptService:WaitForChild("portal.contexts"))
local PlayerContext, ClientContext = Contexts.Player, Contexts.Client

game.Players.PlayerAdded:Connect(function(player)
	Portal:Publish(PlayerContext.Name, "Joined", { Ping = "Pong", JoinedPlayer = player })
end)

local subscription = Portal:Subscription(ClientContext.Name, "Loaded", function(particle, client)
	local f = "[Server][Client-Loaded]: Player [%s] has loaded, client pinged with (%s)"
	local pong = particle.Payload.Ping

	print(f:format(client.Name, pong))
end)
local subscriber = Portal:Subscribe(subscription)
