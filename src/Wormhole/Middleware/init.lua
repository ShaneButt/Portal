local RunService = game:GetService("RunService")

local DEBUGGING_ENABLED = true

local Middleware = {}
Middleware.__index = Middleware

Middleware.Charge = require(script.ChargeParticle)
Middleware.Log = require(script.Logger)

function Middleware.load(external)
	local self = {
		Payload = {},
		Pipeline = {}
	}
	if external then
		for _, middleware in pairs(external) do
			if script:FindFirstChild(middleware) then
				table.insert(self.Pipeline, require(script:FindFirstChild(middleware)))
			end
		end
	end
	table.insert(self.Pipeline, Middleware.Charge)
	
	if RunService:IsStudio() and DEBUGGING_ENABLED then
		table.insert(self.Pipeline, Middleware.Log)
	end
	setmetatable(self, Middleware)

	return self
end

function Middleware:Warp(data, portal, pipeline)
	pipeline = if pipeline then pipeline else self.Pipeline

	local n = next(pipeline)

	if n ~= nil then
		self.Payload = pipeline[n](data, portal)
		table.remove(pipeline, n)
		self:Warp(self.Payload, portal, pipeline)
		return self.Payload
	else
		return self.Payload
	end
end

return Middleware