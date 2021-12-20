local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local types = require(script.Parent.Types)
local like: { [string]: (obj: any) -> boolean } = types.like

type IContext = types.IContext
type ISubscription = types.ISubscription
type IWormhole = types.IWormhole
type IParticle = types.IParticle

local Context: IContext = require(script.Parent.Context)
local Subscription: ISubscription = require(script.Parent.Subscription)
local Middleware = require(script.Middleware)

local Storage: Folder = ReplicatedStorage:FindFirstChild("Portal") :: Folder

if not Storage then
	Storage = ReplicatedStorage:WaitForChild("Portal") :: Folder
end

--[=[
	@class Wormhole

	If [Portal](/api/Portal) is the gateway into the framework, think of Wormhole as being the magic black box of the framework that handles the communication between the client and server.
]=]
local Wormhole: IWormhole = {} :: IWormhole

--[=[
	@prop _Storage Folder
	@within Wormhole
	@readonly
	The location of the Remote storage, `ReplicatedStorage.Portal`.
]=]
Wormhole._Storage = Storage

--[=[
	@prop _Contexts {[string]: IContext}
	@within Wormhole
	A collection of Context objects managed by this Wormhole.
]=]
Wormhole._Contexts = {}

Wormhole.__index = Wormhole

--[=[
	Will instantiate a new Wormhole with the given list of middleware.

	@param middleware {string} -- A list of middleware - found in `Portal/Wormhole/Middleware` - to be used by the new Wormhole.

	@return IWormhole -- The new Wormhole.
]=]
function Wormhole.new(middleware: { string }): IWormhole
	local self = setmetatable({}, Wormhole)
	self.Middleware = Middleware.load(middleware)

	return self :: IWormhole
end

--[=[
	Compare an object to an IWormhole using a non-strict likeness type check.

	@param obj any -- The object to compare.

	@return (boolean, string?) -- `true` if IWormhole-like, `false` otherwise.
]=]
function Wormhole.like(wormhole: IWormhole): (boolean, string?)
	return like.isWormhole(wormhole)
end

--[=[
	Will either retrieve an existing Context, or insantiates a new one with the given name.

	@param wormhole IWormhole -- The Wormhole being used.
	@param context string -- The name of the Context to find or make.

	@return IContext -- The Context object found or made.
]=]
function Wormhole.addContext(wormhole: IWormhole, context: string): IContext
	if wormhole and wormhole._Contexts[context] then
		return wormhole._Contexts[context]
	end

	local new: IContext = Context.new(context)
	wormhole._Contexts[context] = new

	return wormhole._Contexts[context]
end

--[=[
	Will make a new Subscription to the given Context-Action and attaches a callback to be run when the Context-Action receives data.

	@param context string -- The name of the Context to find or make.
	@param action string -- The action to make a subscription to.
	@param callback? (particle: IParticle, sender: Player?) -> ()? -- The callback to attach to the subscription.

	@return IContext - The Context object found or made.
]=]
function Wormhole.makeSubscription(
	context: string,
	action: string,
	callback: (particle: IParticle, sender: Player?) -> nil?
): ISubscription
	return Subscription.new(context, action, callback)
end

--[=[
	Will subscribe to the given Subscription's Context and 

	@param wormhole IWormhole -- The Wormhole being used.
	@param subscription ISubscription -- The Subscription to subscribe to
	@param callback (particle: IParticle, sender: Player?) -> () -- The callback to run when the Context/Action is published to.

	@return () -> () -- The unsubscriber function, used to disconnect the connection to the RemoteEvent made by this subscriber.
]=]
function Wormhole.subscribe(
	wormhole: IWormhole,
	subscription: ISubscription,
	callback: (particle: IParticle, sender: Player?) -> nil
): () -> nil
	local portalContext: IContext = wormhole.addContext(wormhole, subscription.Context)
	local unsubscribe = portalContext:Subscribe(subscription, callback)

	return unsubscribe
end

--[=[
	Will run data through the given Wormhole's middleware, transforming the data into an [IParticle](/api/Portal#IParticle).

	@param wormhole IWormhole -- The Wormhole being used.
	@param portal {[string]: string} -- A dictionary with two fields: Context and Action, which are the names of the Context-Action being targeted.
	@param data {[string]: any} -- The data to feed through the middleware.

	@return IParticle -- The particle made using the data sent produced by the final middleware step, [ChargeParticle](/api/ChargeParticle).
]=]
function Wormhole.applyMiddleware(wormhole: IWormhole, portal: { [string]: string }, data: { [string]: any }): IParticle
	local middleware = wormhole.Middleware

	return middleware:Warp(data, portal)
end

--[=[
	Dispatches data to the given Context-Action through transforming the data through the middleware and eventually Publishing to the Context.

	@param wormhole IWormhole -- The Wormhole being used.
	@param context IContext -- The Context object to publish to.
	@param action string -- The action to action to dispatch to.
	@param data {[string]: any} -- The data you are sending through the Wormhole
	@param target? Player -- The player recieving this data, or all clients (if performed on the server and nil). If performed on the client will be received by the server if not specified.
]=]
function Wormhole.dispatch(wormhole: IWormhole, context: IContext, action: string, data: any, target: Player?): nil
	local portal: { [string]: string } = { Context = context.Name, Action = action }
	local particle = Wormhole.applyMiddleware(wormhole, portal, data)
	context:Publish(particle, target)
end

return Wormhole
