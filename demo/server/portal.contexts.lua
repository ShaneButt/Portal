local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages: Folder = ReplicatedStorage:WaitForChild("Packages")
local Portal = require(Packages:WaitForChild("Portal"))
Portal = Portal.new()

local Contexts = {
	Server = Portal:Context("Server"),
	Client = Portal:Context("Client"),
	Player = Portal:Context("Player"),
	Economy = Portal:Context("Economy"),
}

return Contexts
