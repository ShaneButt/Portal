return function(data, portal)
	local particle = {
		Timestamp = DateTime.now(),
		Payload = data,
		Context = portal.Context,
		Action = portal.Action
	}

	return particle
end