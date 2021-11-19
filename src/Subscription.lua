local types = require(script.Parent.Types)
local t = require(script.Parent.Parent.t)

export type ISubscription = types.ISubscription
type IParticle = types.IParticle

local Subscription: ISubscription = {}
Subscription.__index = Subscription

function Subscription.new(context: string, action: string, callback: () -> ()?): ISubscription

	local self: ISubscription = setmetatable({}, Subscription)
	self.Context = context
	self.Action = action
	self.Callback = callback

	return self :: ISubscription
end

function Subscription.is(obj: any): boolean
	return types.isSubscription(obj)
end

function Subscription:Subscribe(callback: (particle: IParticle) -> nil): ISubscription
	self.Callback = callback
	return self
end

return Subscription