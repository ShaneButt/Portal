local Portal = require(game:GetService("ReplicatedStorage").Packages.Portal)

local PlayerReady = Portal:Subscribe("SERVER", "PlayerReady", function(particle, sender)
	print(("[Server-Portal]: %s is ready, they sent: "):format(sender.Name), particle.Payload)
	Portal:Publish("CLIENT", "Ready", {"Pong!"})
end)

--print("[Server-Portal]: Server ready")