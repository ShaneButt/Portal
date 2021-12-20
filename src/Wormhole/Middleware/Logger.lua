local RunService: RunService = game:GetService("RunService")

--[=[
	Logs the particle to the console, useful for simple debugging.

	@return IParticle
]=]
return function(particle, portal)
	local sent = "[%s][%s-Logger]: Particle sent through Action (%s) on Context (%s): "

	local context, action = particle.Context, particle.Action
	local timestamp = particle.Timestamp
	local realm = if RunService:IsServer() then "Server" else "Client"

	print(sent:format(timestamp:FormatLocalTime("HH:mm:ss:SSS", "en-us"), realm, action, context), particle)

	return particle
end
