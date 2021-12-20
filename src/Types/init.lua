local Ancestor = script.Parent.Parent
local t: { [string]: any } = require(Ancestor:FindFirstChild("t"))

local ContextCheck: (obj: any) -> (boolean, string?) = require(script.IContext)
local SubscriptionCheck: (obj: any) -> (boolean, string?) = require(script.ISubscription)
local WormholeCheck: (obj: any) -> (boolean, string?) = require(script.IWormhole)
local ParticleCheck: (obj: any) -> (boolean, string?) = require(script.IParticle)

export type IContext = ContextCheck.IContext
export type ISubscription = SubscriptionCheck.ISubscription
export type IWormhole = WormholeCheck.IWormhole
export type IParticle = ParticleCheck.IParticle

local Checks: { [string]: (obj: any) -> (boolean, string?) } = {
	["IContext"] = ContextCheck,
	["ISubscription"] = SubscriptionCheck,
	["IWormhole"] = WormholeCheck,
	["IParticle"] = ParticleCheck,
}

local Types = {
	t = t,
	like = Checks,
}

return Types
