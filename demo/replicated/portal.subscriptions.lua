local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages: Folder = ReplicatedStorage:WaitForChild("Packages")
local Portal = require(Packages:WaitForChild("Portal"))
Portal = Portal.new()

local Player = Players.LocalPlayer

local Subscriptions = {
	Client = { -- client subscriptions
		PlayerJoined = Portal:Subscription("Player", "Joined", function(particle, client)
			local f = "[Client][Player-Joined]: Player [%s]%s joined the server, server pinged with (%s)."
			local payload = particle.Payload
			local joined = payload.JoinedPlayer
			local pong = payload.Ping
			local localPlayer = joined == Player and " (LocalPlayer)" or ""
			--print(f:format(joined.Name, localPlayer, pong))
		end),
	},

	Server = { -- server subscriptions
		ClientLoaded = Portal:Subscription("Client", "Loaded", function(particle, client)
			local f = "[Server][Client-Loaded]: Player [%s] has loaded, client pinged with (%s)"
			local pong = particle.Payload.Ping

			--print(f:format(client.Name, pong))
		end),
	},
}

return Subscriptions
