local t = require(script.Parent.Parent.Parent.t)

local Subscription = require(script.Parent.ISubscription)
type ISubscription = Subscription.ISubscription

local Particle = require(script.Parent.IParticle)
type IParticle = Particle.IParticle

local IsContext = t.interface({
	Name = t.string,
	Remote = t.instanceIsA("RemoteEvent"),
	Subscriptions = t.map(t.callback, Subscription)
})

export type IContext = {
	Name: string,
	Remote: RemoteEvent,
	Subscriptions: {[() -> nil]: ISubscription},
	Actions: {string},
	
	__index: IContext,
	new: (contextName: string) -> IContext,
	is: (obj: any) -> boolean,

	Publish: (
		self: IContext,
		action: string,
		data: any
	) -> nil,
	
	Subscribe: (
		self: IContext,
		subscription: ISubscription,
		callback: (particle: IParticle, sender: Player?) -> nil
	) -> () -> nil,
	
	Destroy: (self: IContext) -> nil
}

return function(obj)
	return IsContext(obj) :: boolean
end