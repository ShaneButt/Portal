local t = require(script.Parent.Parent.Parent.t)

local IsSubscription = t.interface({
	Context = t.string,
	Action = t.string,
	Callback = t.optional(t.callback),
})

local Particle = require(script.Parent.IParticle)
type IParticle = Particle.IParticle

export type ISubscription = {
	Context: string,
	Action: string,
	Callback: (particle: IParticle) -> nil,

	__index: ISubscription,

	new: (context: string, action: string, callback: () -> nil?) -> ISubscription,
	is: (obj: any) -> boolean,

	Subscribe: (self: ISubscription, callback: (particle: IParticle) -> nil) -> ISubscription,
}

return function(obj)
	return IsSubscription(obj) :: boolean
end