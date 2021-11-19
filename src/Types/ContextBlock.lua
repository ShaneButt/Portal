local t = require(script.Parent.Parent.Parent.t)

local IContext = require(script.Parent.IContext)
type IContext = IContext.IContext

local isContextBlock = t.interface({
	Context = t.any,
	Actions = t.interface({
		[t.string] = t.interface({ t.callback }),
	}),
})

export type ContextBlock = {
	Context: IContext,
	Actions: { action: string },
}

return function(obj)
	return isContextBlock(obj) :: boolean
end
