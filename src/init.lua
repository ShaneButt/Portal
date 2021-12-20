local HttpService: HttpService = game:GetService("HttpService")
local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService: RunService = game:GetService("RunService")

local types = require(script.Types)
local t = types.t
local like = types.like

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
type IParticle = types.IParticle
type ISubscription = types.ISubscription
type IWormhole = types.IWormhole

local Wormhole = require(script.Wormhole)

--[=[
	@class Portal

	Portal is the gateway into the framework, it's all you could need to use. The whole framework is exposed and documented such that developers can extend the functionality of Portal through middleware, or even also perhaps to help maintain the project in the future.
]=]
local Portal = {}
Portal.__index = Portal

Portal.Types = require(script.Types)

--[=[
	@prop Wormhole IWormhole
	@within Portal

	The Wormhole bound to this Portal.
]=]
Portal.Wormhole = {} :: IWormhole

--[=[
	Will instantiate a new Portal with the given middleware.

	@param middleware? {string} -- A list of middleware names to install with Portal.

	@return Portal -- a Portal instance.
]=]
function Portal.new(middleware: { string }?)
	local self = {}
	self.Wormhole = Wormhole.new(middleware)
	setmetatable(self, Portal)

	return self
end

--[=[
	Will retrieve an `IContext` from a given input string if it exists, or creates a new one otherwise.

	@param context string -- The name of the context to retrieve or make.

	@return IContext -- the `IContext` object with the given name.
]=]
function Portal:Context(context: string): IContext
	return self.Wormhole.addContext(self.Wormhole, context)
end

--[=[
	Will make an `ISubscription` from given inputs.

	@param context string -- The name of the context to make a subscription to.
	@param action string -- The action to make a subcription to.
	@param cb? (particle: IParticle, target: Player?) -> () -- The callback to run when the Context/Action is published to.

	@return ISubscription -- the `ISubscription` object created.
]=]
function Portal:Subscription(
	context: string,
	action: string,
	cb: (particle: IParticle, target: Player?) -> nil?
): ISubscription
	return self.Wormhole.makeSubscription(context, action, cb)
end

--[=[
	Used to retrieve the listener function and subscribe to a context for events when actions are dispatched. Can be made either with an existing ISubscription or from inputs to make a new one.

	@param sub ISubscription -- The subscription to subscribe with
	@param context string? -- The name of the context to make a subscription to, to subscribe with.
	@param action string? -- The action to subscribe to.
	@param cb (particle: IParticle, target: Player?) -> () -- The callback to run when the Context/Action is published to.

	@return () -> () -- The unsubscriber function used to disconnect the subscription from the RemoveEvent.
]=]
function Portal:Subscribe(
	sub: ISubscription?,
	context: string?,
	action: string?,
	cb: (particle: IParticle, target: Player?) -> nil
): () -> nil
	local subscription: ISubscription = sub or self:Subscription(context, action, cb) :: ISubscription
	return self.Wormhole.subscribe(self.Wormhole, subscription, cb)
end

--[=[
	Will initate the Publish sequence, transforming the data sent through the middleware pipeline, and eventually dispatching to the Context/Action RemoteEvent.

	@param context string -- The name of the context to publish to.
	@param action string -- The action to publish to.
	@param data {[string]: any} -- The data you are sending through the remote.
	@param target? Player -- the target, or nil from the server, triggering the event.
]=]
function Portal:Publish(context: string, action: string, data: { [string]: any }, target: Player?)
	local portalContext = self:Context(context)
	self.Wormhole.dispatch(self.Wormhole, portalContext, action, data, target)
end

--[=[
	Will `Warp` (apply middleware to) the data you wish to transmit through the context/action.

	@param context IContext -- The context to warp data through.
	@param action string -- The action being targeted.
	@param data {[string]: any} -- The data to warp (transform).

	@return IParticle -- All data sent through the middleware will return an IParticle object.
]=]
function Portal:Warp(context: IContext, action: string, data: { [string]: any }): IParticle
	local portal = { Context = context.Name, Action = action }

	return self.Wormhole.applyMiddleware(self.Wormhole, portal, data)
end

return Portal
