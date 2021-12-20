---
sidebar_position: 1
title: "Basic Usage"
---

Portal is designed to be simple and friendly. The front-facing API consists of minimal methods that allow you to do a great deal with the underlying architecture.


## Context Definitions
Context Definitions represent RemoteEvent's and are used to traffic your client-server networking. While they represent RemoteEvent's they are simple Data that wraps around them.
A great way to define your context-actions is by using a definition module, the practice is to call this `portal.contexts`:
```lua title="demo/server/portal.contexts.lua"
--// ...Portal imports
local Contexts = {
	Server = Portal:Context("Server"),
	Client = Portal:Context("Client"),
	Player = Portal:Context("Player"),
	Economy = Portal:Context("Economy")
}

return Contexts
```

In practice this is located in `ServerScriptService` and is `require`d into your server-side script that is using Portal; this will initialise the events within a `Portal` folder inside `ReplicatedStorage`. We keep Contexts hidden behind the server in our demo, it's your choice how you handle this though!
```lua title="demo/server/portal.server.lua"
--// ...Portal imports
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
```

## Subscription Definitions
Subscription Definitions represent a way of receiving information, either from the client on the server or vice versa. They wrap around a callback and will fire that given callback when information is received to the Context-Action the Subscription is bound to.
```lua title="demo/replicated/portal.subscriptions.lua"
--// ...Portal imports
local Subscriptions = {
	Client = {
		PlayerJoined = Portal:Subscription("Player", "Joined", function(particle)
			local f = "[Client][Player-Joined]: Player [%s] %s joined the server, server pinged with (%s)."
			local payload = particle.Payload
			local joined = payload.JoinedPlayer
			local pong = payload.Ping
			local localPlayer = joined == Player and "(LocalPlayer)" or ""
			print(f:format(joined.Name, localPlayer, pong))
		end),
	},

	Server = {
		ClientLoaded = Portal:Subscription("Client", "Loaded", function(particle, client)
			local f = "[Server][Client-Loaded]: Player [%s] has loaded, client pinged with (%s)"
			local pong = particle.Payload.Ping

			print(f:format(client.Name, pong))
		end)
	}
}

return Subscriptions
```

From this then, we could do something like this:
```lua title="demo/client/portal.client.lua"
--// ...Portal imports
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
```
... Which will then subscribe to the Subscription's corresponding Context through Portal's Wormhole.

:::caution

Subscribing directly to a subscription, only sets the callback, if you wish to 'activate' a subscription, you must subscribe to a context object.

:::