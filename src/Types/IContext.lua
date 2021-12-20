local t = require(script.Parent.Parent.Parent.t)

local Subscription = require(script.Parent.ISubscription)
type ISubscription = Subscription.ISubscription

local Particle = require(script.Parent.IParticle)
type IParticle = Particle.IParticle

local likeContext: (obj: any) -> (boolean, string?) = t.interface({
	Name = t.string,
	Remote = t.instanceIsA("RemoteEvent"),
	Subscriptions = t.map(t.callback, Subscription),
})

--[=[
	@interface IContext
	@within Portal
	.Name string -- The Name of the Context.
	.Remote RemoteEvent -- The RemoteEvent this Context owns.
	.Actions {string} -- A list of actions that belong to this Context.
	.Subscriptions {[() -> ()]: ISubscription} -- A dictionary of unsubscriber function for the keys and their associated Subscriptions as values.
]=]
export type IContext = {
	Name: string,
	Remote: RemoteEvent,
	Subscriptions: { [() -> nil]: ISubscription },
	Actions: { string },

	__index: IContext,
	new: (contextName: string) -> IContext,
	like: (obj: any) -> (boolean, string?),

	Publish: (self: IContext, particle: IParticle, sender: Player?) -> nil,

	Subscribe: (
		self: IContext,
		subscription: ISubscription,
		callback: (particle: IParticle, sender: Player?) -> nil
	) -> () -> nil,

	Destroy: (self: IContext) -> nil,
}

return function(obj): (boolean, string?)
	return likeContext(obj)
end
