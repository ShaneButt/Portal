local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService: RunService = game:GetService("RunService")
local HttpService: HttpService = game:GetService("HttpService")

local t = require(script.Parent.Parent.t)
local Promise = require(script.Parent.Parent.Promise)

local types = require(script.Parent.Types)
local AwaitForValue = require(script.Parent.Promises.promiseAwaitValue)

local Context = require(script.Parent.Context)
local Subscription = require(script.Parent.Subscription)

local Middleware = require(script.Middleware)

type IContext = types.IContext
type ISubscription = types.ISubscription
type IWormhole = types.IWormhole
type ContextBlock = types.ContextBlock
type IParticle = types.IParticle

local RemoteFolderName= "Portal"
local Storage: Folder = ReplicatedStorage:FindFirstChild(RemoteFolderName) :: Folder

if not Storage then
	if RunService:IsServer() then
		Storage = Instance.new("Folder")
		Storage.Name = RemoteFolderName
		Storage.Parent = ReplicatedStorage
	else
		Storage = ReplicatedStorage:WaitForChild(RemoteFolderName) :: Folder
	end
end

local Wormhole: IWormhole = {}
Wormhole._Storage = Storage
Wormhole._Contexts = {}
Wormhole.__index = Wormhole

function Wormhole.new(middleware: any): IWormhole
	local self = setmetatable({}, Wormhole)
	self.Middleware = Middleware.load(middleware)

	return self :: IWormhole
end

function Wormhole.is(wormhole: IWormhole): boolean
	return types.isWormhole(wormhole)
end

function Wormhole.addContext(wormhole: IWormhole, context: string): ContextBlock
	if wormhole._Contexts[context] then
		return wormhole._Contexts[context]
	end

	local new: IContext = Context.new(wormhole, context)
	wormhole._Contexts[context] = new

	return wormhole._Contexts[context]
end

function Wormhole.makeSubscription(wormhole: IWormhole, context: string, action: string): ISubscription
	local subscription: ISubscription
	subscription = Subscription.new(context, action)
	return subscription
end

function Wormhole.subscribe(wormhole: IWormhole, subscription: ISubscription, callback: ()->nil): ()
	local portalContext: IContext = wormhole.addContext(wormhole, subscription.Context)
	local unsubscribe = portalContext:Subscribe(subscription, callback)
	
	return unsubscribe
end

function Wormhole.applyMiddleware(wormhole: IWormhole, portal: {string}, data: any): IParticle
	local middleware = wormhole.Middleware
	return middleware:Warp(data, portal)
end

function Wormhole.publish(wormhole: IWormhole, context: string, action: string, data: any, to: Player?)
	local portalContext = wormhole.addContext(wormhole, context)
	
	local portal: {string} = {Context=context, Action=action}
	local particle = wormhole.applyMiddleware(wormhole, portal, data)
	portalContext:Publish(wormhole, action, particle, to)
end

return Wormhole