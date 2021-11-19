local IContext: (obj: any) -> boolean = require(script.IContext)
local ISubscription: (obj: any) -> boolean = require(script.ISubscription)
local IWormhole: (obj: any) -> boolean = require(script.IWormhole)
local ContextBlock: (obj: any) -> boolean = require(script.ContextBlock)
local IParticle: (obj: any) -> boolean = require(script.IParticle)

export type IContext = IContext.IContext
export type ISubscription = ISubscription.ISubscription
export type IWormhole = IWormhole.IWormhole
export type ContextBlock = ContextBlock.ContextBlock
export type IParticle = IPackage.IParticle

local Checks: { [string]: (obj: any) -> boolean } = {
	["isContext"] = IContext,
	["isSubscription"] = ISubscription,
	["isWormhole"] = IWormhole,
	["isContextBlock"] = ContextBlock,
	["isParticle"] = IParticle,
}

return Checks
