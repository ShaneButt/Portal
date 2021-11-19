local t = require(script.Parent.Parent.Parent.t)

local function isDateTime(value: any): (boolean, string?)
	local valueType = typeof(value)
	if valueType == "DateTime" then
		return true
	else
		return false, string.format("DateTime expected, got %s", valueType)
	end
end

local isParticle: (obj: any) -> boolean = t.interface({
	Context = t.string,
	Action = t.string,
	DateTime = isDateTime,
	Payload = t.map(t.string, t.any),
})

export type IParticle = {
	Context: string,
	Action: string,
	Timestamp: DateTime,
	Payload: { [string]: any },
}

return function(obj: any): boolean
	return isParticle(obj)
end
