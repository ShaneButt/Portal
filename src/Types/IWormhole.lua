local t = require(script.Parent.Parent.Parent.t)

local ContextBlock: (obj: any) -> boolean = require(script.Parent.ContextBlock)
local ISubscription: (obj: any) -> boolean = require(script.Parent.ISubscription)
local IContext: (obj: any) -> boolean = require(script.Parent.IContext)
local IParticle: (obj: any) -> boolean = require(script.Parent.IParticle)

type ContextBlock = ContextBlock.ContextBlock
type ISubscription = ISubscription.ISubscription
type IContext = IContext.IContext
type IParticle = IParticle.IParticle

local isWormhole: (obj: any) -> boolean = t.interface({
	_Storage = t.instanceIsA("Folder"),
	_Contexts = t.map(t.string, t.any)
})

export type IWormhole = {
	_Storage: Folder,
	_Contexts: {[string]: ContextBlock},

	__index: IWormhole,

	new: () -> IWormhole,
	is: (obj: any) -> boolean,

	awaitContext: (
		wormhole: IWormhole,
		context: string, 
		timeout: number?
	) -> ContextBlock,
	
	addContext: (
		wormhole: IWormhole,
		context: string
	) -> ContextBlock,
	
	makeSubscription: (
		wormhole: IWormhole,
		context: string,
		action: string
	) -> ISubscription,

	doSubscribe: (
		wormhole: IWormhole,
		subscription: ISubscription, 
		callback: () -> nil
	) -> () -> nil,

	applyMiddleware: (
		wormhole: IWormhole,
		portal: {string},
		data: any
	) -> IParticle,

	publishMessage: (
		wormhole: IWormhole,
		context: string, 
		action: string, 
		data: any, 
		to: Player?
	) -> nil
}

return function(obj)
	return isWormhole(obj) :: boolean
end