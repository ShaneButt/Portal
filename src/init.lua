local HttpService: HttpService = game:GetService("HttpService")
local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService: RunService = game:GetService("RunService")

local t = require(script.Parent.t)
local types = require(script.Types)

local RemoteLocation = "Portal"
local Storage: Folder = ReplicatedStorage:FindFirstChild(RemoteLocation) :: Folder

if not Storage then
	if RunService:IsServer() then
		Storage = Instance.new("Folder")
		Storage.Name = RemoteLocation
		Storage.Parent = ReplicatedStorage
	else
		Storage = ReplicatedStorage:WaitForChild(RemoteLocation)
	end
end

type IContext = types.IContext
type ISubscription = types.ISubscription
type IWormhole = types.IWormhole

local Wormhole = require(script.Wormhole)

local Portal = {}
Portal.Wormhole = Wormhole.new()

function Portal:Context(context: string): IContext
	return Portal.Wormhole.awaitContext(Portal.Wormhole, context)
end

function Portal:Subscription(context: string, action: string, cb: () -> ()?): ISubscription
	return Portal.Wormhole.makeSubscription(Portal.Wormhole, context, action, cb)
end

function Portal:Subscribe(context: string, action: string, cb: (particle: IParticle, sender: Player?) -> nil)
	local subscription: ISubscription = Portal:Subscription(context, action, cb)
	return Portal.Wormhole.subscribe(Portal.Wormhole, subscription, cb)
end

function Portal:Publish(context: string, action: string, data: any, player: Player?)
	return Portal.Wormhole.publish(Portal.Wormhole, context, action, data, player)
end

return Portal
