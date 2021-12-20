local types = require(script.Parent.Types)
local like: { [string]: (obj: any) -> boolean } = types.like
local t = types.t

export type ISubscription = types.ISubscription
type IParticle = types.IParticle

--[=[
	@class Subscription

	A Subscription is exclusively a listening object and cannot be used to publish data. These are to be attached to a Context via the Subscribe method.
	A Subscription will have an associated Context-Action pair as well as a Callback to be ran when the Subscription 'hears' from the Context-Action.
]=]
local Subscription: ISubscription = {} :: ISubscription
Subscription.__index = Subscription

--[=[
	Will instantiate a new Subscription object to link to a Context.

	@param context string -- The name of the Context this Subscription is (or will be) linked to.
	@param action string -- The action this Subscription is listening to.
	@param callback (particle: IParticle, sender: Player?) -> ()? -- The callback to be ran when the Context receives data.

	@return ISubscription -- The new Subscription object.
]=]
function Subscription.new(
	context: string,
	action: string,
	callback: (particle: IParticle, sender: Player?) -> nil?
): ISubscription
	t.strict(t.tuple(t.string, t.string, t.optional(t.callback)))(context, action, callback)

	local self: ISubscription = setmetatable({}, Subscription)
	self.Context = context
	self.Action = action
	self.Callback = callback

	return self :: ISubscription
end

--[=[
	Compare an object to an ISubscription using a non-strict likeness type check.

	@param obj any -- The object to compare

	@return (boolean, string?) -- `true` if ISubscription-like, `false` otherwise.
]=]
function Subscription.like(obj: any): (boolean, string?)
	return like.isSubscription(obj)
end

--[=[
	Attach a callback to this Subscription to be run when the Context-Action this Subscription is bound to recieves a message.

	@param callback (particle: IParticle, sender: Player) -> () -- The callback to run when the Subscription 'hears' from the Context-Action.
]=]
function Subscription:Subscribe(callback: (particle: IParticle, sender: Player) -> nil): nil
	t.strict(t.callback)(callback)

	self.Callback = callback
end

return Subscription
