local t = require(script.Parent.Parent.Parent.t)

local ISubscription: (obj: any) -> (boolean, string?) = require(script.Parent.ISubscription)
local IContext: (obj: any) -> (boolean, string?) = require(script.Parent.IContext)
local IParticle: (obj: any) -> (boolean, string?) = require(script.Parent.IParticle)

type ISubscription = ISubscription.ISubscription
type IContext = IContext.IContext
type IParticle = IParticle.IParticle

local likeWormhole: (obj: any) -> (boolean, string?) = t.interface({
	_Storage = t.instanceIsA("Folder"),
	_Contexts = t.map(t.string, IContext),
	Middleware = t.interface({}),
})
--[=[
	@interface IWormhole
	@within Portal
	._Storage Folder -- The storage folder for Portal's RemoteEvents.
	._Contexts {[string]: IContext} -- The Context managed by this Wormhole.
	.Middleware any -- The Middleware pipeline of this Wormhole.
]=]
export type IWormhole = {
	_Storage: Folder,
	_Contexts: { [string]: IContext },
	Middleware: { string },

	__index: IWormhole,

	new: (middlewarre: any) -> IWormhole,
	like: (obj: any) -> (boolean, string?),

	addContext: (wormhole: IWormhole, context: string) -> IContext,

	makeSubscription: (
		context: string,
		action: string,
		callback: (particle: IParticle, sender: Player?) -> nil?
	) -> ISubscription,

	subscribe: (
		wormhole: IWormhole,
		subscription: ISubscription,
		callback: (particle: IParticle, sender: Player?) -> nil
	) -> () -> nil,

	applyMiddleware: (wormhole: IWormhole, portal: { [string]: string }, data: any) -> IParticle,

	dispatch: (wormhole: IWormhole, context: IContext, action: string, data: any, sender: Player?) -> nil,
}

return function(obj): (boolean, string?)
	return likeWormhole(obj)
end
