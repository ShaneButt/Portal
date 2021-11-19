local Portal = require(game:GetService("ReplicatedStorage").Packages.Portal)

Portal:Subscribe("CLIENT", "Ready", function(particle)
	print("[Client-Portal]: Server responded with: ", particle.Payload)
end)

Portal:Publish("SERVER", "PlayerReady", {"Ping"})