local RunService: RunService = game:GetService("RunService")

local types = require(script.Parent.Types)
local t = require(script.Parent.Parent.t)

export type IContext = types.IContext

type IWormhole = types.IWormhole
type IParticle = types.IParticle

local Context: IContext = {}
Context.__index = Context

function Context.new(wormhole: IWormhole, contextName: string): IContext
	local check = t.strict(t.string)
	check(contextName)

	local self: IContext = setmetatable({}, Context)
	self.Name = contextName

	local remote = wormhole._Storage:FindFirstChild(contextName)
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = contextName
		remote.Parent = wormhole._Storage
	end

	self.Remote = remote

	self.Subscriptions = {}
	self.Actions = {}
	
	return self :: IContext
end

function Context.is(obj: any): boolean
	return types.isContext(obj)
end

function Context:Subscribe(subscription: ISubscription, callback: (particle: IParticle, sender: Player?) -> nil): () -> nil
	
	if not table.find(self.Actions, subscription.Action) then
		table.insert(self.Actions, subscription.Action)
	end

	callback = callback or subscription.Callback

	local remoteConnection: RBXScriptConnection

	if RunService:IsServer() then
		remoteConnection = self.Remote.OnServerEvent:Connect(
			function(sender: Player, particle: IParticle)
				print("[Client->Server]")
				if subscription.Action == particle.Action then
					local check = t.strict(t.instanceIsA("Player"))
					check(sender)
					types.isParticle(particle)

					callback(particle, sender)
				end
			end
		)
	else
		remoteConnection = self.Remote.OnClientEvent:Connect(
			function(particle: IParticle)
				print("[Server->Client]")
				if subscription.Action == particle.Action then
					types.isParticle(particle)

					callback(particle)				
				end
			end
		)
	end

	local subscriptions: {[()->nil]: ISubscription} = self.Subscriptions

	local function unsubscribe()
		table.remove(subscriptions, table.find(subscriptions, subscription))
		remoteConnection:Disconnect()
	end
	subscriptions[unsubscribe] = subscription
	
	return unsubscribe
end

function Context:Publish(wormhole: IWormhole, action: string, particle: IParticle, receiver: Player?)
	local _remote = self.Remote

	if RunService:IsServer() then
		if receiver then
			_remote:FireClient(receiver, particle)
		else
			_remote:FireAllClients(particle)
		end
	else
		_remote:FireServer(particle)
	end
end

function Context:Destroy()
	for unsubscribe, subscription in pairs(self.Subscriptions) do
		unsubscribe()
		table.remove(self.Subscriptions, subscription)
	end
end

return Context
