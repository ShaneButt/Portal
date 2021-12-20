local t = require(script.Parent.Parent.Parent.t)

local likeParticle: (obj: any) -> (boolean, string?) = t.interface({
	Context = t.string,
	Action = t.string,
	Timestamp = t.DateTime,
	Payload = t.map(t.string, t.any),
})

--[=[
	@interface IParticle
	@within Portal
	.Context string -- The Context this Particle was sent to.
	.Action string -- The Action this Particle was sent to.
	.Timestamp DateTime -- The Timestamp this Particle was sent at.
	.Payload {[string]: any} -- The Payload belonging to this Particle.
]=]
export type IParticle = {
	Context: string,
	Action: string,
	Timestamp: DateTime,
	Payload: any,
}

return function(obj: { [string]: any }): (boolean, string?)
	return likeParticle(obj)
end
