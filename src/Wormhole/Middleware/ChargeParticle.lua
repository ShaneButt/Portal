local types = require(script.Parent.Parent.Parent.Types)

type IParticle = types.IParticle

--[=[
	Charges the data sent into a Particle.

	@return IParticle -- the charged data, ready to be sent.
]=]
return function(data: any, portal: { [string]: string }): IParticle
	local particle: IParticle = {
		Timestamp = DateTime.now(),
		Payload = data,
		Context = if portal then portal.Context else "",
		Action = if portal then portal.Action else "",
	} :: IParticle

	return particle
end
