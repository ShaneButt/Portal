local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local Promise = require(script.Parent.Parent.Parent.Promise)

local function promiseAwaitForValue(value: string, list: { [string]: any }): any
	local conn: RBXScriptConnection
	local promise = Promise.new(function(resolve, reject, onCancel)
		conn = RunService.Heartbeat:Connect(function(delta)
			local _val = list[value]
			if _val then
				resolve(_val)
			end
		end)
		onCancel(function()
			conn:Disconnect()
		end)
	end):finally(function()
		if conn then 
			conn:Disconnect()
		else 
			return 
		end
	end)

	return promise
end

return promiseAwaitForValue
