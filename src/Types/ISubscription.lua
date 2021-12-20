local t = require(script.Parent.Parent.Parent.t)

local likeSubscription: (obj: any) -> (boolean, string?) = t.interface({
	Context = t.string,
	Action = t.string,
	Callback = t.optional(t.callback),
})

local Particle = require(script.Parent.IParticle)
type IParticle = Particle.IParticle

--[=[
	@interface ISubscription
	@within Portal
	.Context string -- The name of the context this subscription is for.
	.Action string -- The name of the action this subscription is listening to.
	.Callback (particle: IParticle, sender: Player?) -> () -- The function to call when the subscription is published to.
]=]
export type ISubscription = {
	Context: string,
	Action: string,
	Callback: (particle: IParticle, sender: Player?) -> nil,

	__index: ISubscription,

	new: (context: string, action: string, callback: (particle: IParticle, sender: Player?) -> nil?) -> ISubscription,
	like: (obj: any) -> (boolean, string?),

	Subscribe: (self: ISubscription, callback: (particle: IParticle, sender: Player?) -> nil) -> nil,
}

return function(obj): (boolean, string?)
	return likeSubscription(obj)
end
