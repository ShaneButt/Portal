local RunService: RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local types = require(script.Parent.Types)
local like: { [string]: (obj: any) -> boolean } = types.like
local t: { [string]: any } = types.t

export type IContext = types.IContext

type IWormhole = types.IWormhole
type ISubscription = types.ISubscription
type IParticle = types.IParticle

local Storage: Folder = ReplicatedStorage:FindFirstChild("Portal") :: Folder

--[=[
	@class Context

	A Context can be thought of as a collection of actions wherein you can send messages between the client and the server.

	 A Context has a list of it's subscribers and actions, it can also listen to and send messages to RemoteEvents, and can even be Destroyed in order to clean up it's connections.
]=]
local Context: IContext = {} :: IContext
Context.__index = Context

--[=[
	Will instantiate a new Context object. If not made through Wormhole (directly using `Context.new("")`, this will exist outside of Portal's bounds.

	@param name string -- The name to give this Context

	@return IContext -- The new Context object.
]=]
function Context.new(name: string): IContext
	t.strict(t.string)(name)

	local self: IContext = setmetatable({}, Context)
	self.Name = name

	local remote = Storage:FindFirstChild(name)
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = Storage
	end

	self.Remote = remote :: RemoteEvent

	self.Subscriptions = {}
	self.Actions = {}

	return self :: IContext
end

--[=[
	Compare an object to an IContext using a non-strict likeness type check.

	@param obj any -- The object to compare

	@return (boolean, string?) -- `true` if IContext-like, `false` otherwise.
]=]
function Context.like(obj: any): (boolean, string?)
	return like.IContext(obj)
end

--[=[
	Will attach a callback to a given Subscription and `Connect` to Context's RemoteEvent.

	Callback's are only fired if certain conditions are met:
	- The Subscription passed must associate with the Context used to call this method,
	- When the Context is published to (firing the RemoteEvent), the Action within the Particle must match the action of the subscription passed,
	- The Subscription's action must belong within the Context's actions.

	@param subscription ISubscription -- The subscription to subscribe to.
	@param callback: (particle: IParticle, target: Player?) -> () -- The callback function to run when the Context gets published to.

	@return () -> () -- The unsubscriber method, which will disconnect the connection to the RemoteEvent.
]=]
function Context:Subscribe(
	subscription: ISubscription,
	callback: (particle: IParticle, target: Player?) -> nil
): () -> nil
	t.strict(t.tuple(like.ISubscription, t.callback)(subscription, callback))

	if not table.find(self.Actions, subscription.Action) then
		table.insert(self.Actions, subscription.Action)
	end

	callback = callback or subscription.Callback

	local remoteConnection: RBXScriptConnection

	if RunService:IsServer() then
		remoteConnection = self.Remote.OnServerEvent:Connect(function(target: Player, particle: IParticle)
			if self.Name == subscription.Context and subscription.Action == particle.Action then
				local check = t.strict(t.instanceIsA("Player"), like.IParticle)
				check(target, particle)

				callback(particle, target)
			end
		end)
	else
		remoteConnection = self.Remote.OnClientEvent:Connect(function(particle: IParticle)
			if self.Name == subscription.Context and subscription.Action == particle.Action then
				local check = t.strict(like.IParticle)
				check(particle)

				callback(particle)
			end
		end)
	end

	local subscriptions: { [() -> nil]: ISubscription } = self.Subscriptions

	local function unsubscribe()
		table.remove(subscriptions, table.find(subscriptions, subscription))
		remoteConnection:Disconnect()
	end
	subscriptions[unsubscribe] = subscription

	return unsubscribe
end

--[=[
	This method will fire a remote event relating to the given action and will send the Particle - must have gone through middleware and have been charrged by the ChargeParticle middleware - through it.

	@param action string -- The action to Publish to
	@param particle IParticle -- the data, sent through middleware and charged, to fire through the Remote.
	@param target Player? -- The player, or the server if nil, triggering the publishing.
]=]
function Context:Publish(particle: IParticle, target: Player?): nil
	t.strict(t.tuple(like.IParticle, t.optional(t.instanceIsA("Player"))))(particle, target)

	local _remote = self.Remote

	if RunService:IsServer() then
		if target then
			_remote:FireClient(target, particle)
		else
			_remote:FireAllClients(particle)
		end
	else
		_remote:FireServer(particle)
	end
end

--[=[
	This will Destroy the Context and cleanup it's connections.
]=]
function Context:Destroy(): nil
	for unsubscribe: () -> nil in pairs(self.Subscriptions) do
		t.strict(t.callback)(unsubscribe)
		unsubscribe()
	end
end

return Context
