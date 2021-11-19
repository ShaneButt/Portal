local RunService: RunService = game:GetService("RunService")

return function(particle, portal)
	local sent = "[%s][%s-Logger]:\n\t[%s/%s]: "
	local context, action = particle.Context, particle.Action
	local timestamp, payload = particle.Timestamp, particle.Payload
	local realm = if RunService:IsServer() then "Server" else "Client"
	
	print(
		sent:format(
			timestamp:FormatLocalTime("HH:mm:ss:SSS", "en-us"),
			realm,
			context,
			action
		), 
		payload
	)

	return particle
end