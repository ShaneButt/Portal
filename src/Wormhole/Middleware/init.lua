local RunService = game:GetService("RunService")

local types = require(script.Parent.Parent.Types)

type IParticle = types.IParticle

local DEBUGGING_ENABLED = true

--[=[
	@class Middleware
	To be documented.
]=]
local Middleware = {}
Middleware.__index = Middleware

Charge = require(script.ChargeParticle)
Logger = require(script.Logger)

--[=[
	Instantiates a new Middleware and loads the given middleware into its pipeline.

	@param middleware {string} -- A list of middleware, by name, to be loaded into the Middleware's pipeline.

	@return Middleware
]=]
function Middleware.load(middleware: { string }?)
	local self = {
		Particle = {},
		Pipeline = {},
	}
	if middleware then
		for _, executables in ipairs(middleware) do
			if script:FindFirstChild(executables) then
				table.insert(self.Pipeline, require(script:FindFirstChild(executables)))
			end
		end
	end
	table.insert(self.Pipeline, Charge)

	if RunService:IsStudio() and DEBUGGING_ENABLED then
		table.insert(self.Pipeline, Logger)
	end
	setmetatable(self, Middleware)

	return self
end

--[=[
	Transforms the data being sent and sends it through the middleware's pipeline.

	@param data {[string]: any} -- The data being sent through the middleware pipeline.
	@param portal {[string]: string} -- A dictionary with two fields: Context and Action which are the names of the Context-Action being targeted.
	@param pipeline { (data: { [string]: any}, portal: { [string]: string }) -> IParticle } -- A list of middleware functions that take data and portal as arguments.

	@return IParticle -- The resulting Particle, after going through the middleware and being Charged.
]=]
function Middleware:Warp(
	data: { [string]: any },
	portal: { [string]: string },
	pipeline: { (data: { [string]: any }, portal: { [string]: string }) -> IParticle }?
): IParticle
	pipeline = if pipeline then pipeline else self.Pipeline

	local n = next(pipeline)

	if n ~= nil then
		self.Particle = pipeline[n](data, portal)
		table.remove(pipeline, n)
		return self:Warp(self.Particle, portal, pipeline)
	else
		return self.Particle
	end
end

return Middleware
