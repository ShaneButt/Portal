# Portal
Built with [Rojo](https://github.com/rojo-rbx/rojo) 7.0.0.

A typed Luau publish-subscribe networking framework based on [postal.js](https://github.com/postaljs/postal.js) and inspired by [Sayhisam's Ropost](https://github.com/sayhisam1/Ropost) which is an alternative to this package.

A publish-subscribe model was chosen to simplify and make client-server communication less bothersome, simply subscribe to actions and publish data to them!

Portal is designed on Contexts and Actions rather than Channels and Topics; functionally they're identical, but in my opinion, more accurately named, specifically for Roblox.



# API Usage
Portal aims to make Networking simple by providing two core methods and is based on the postal.js package, which means you can check their documentation as well as Portal's!

You can subscribe to a Context-Action in the following manner, you should use the returned function to completely disconnect the subscription:
```lua
Portal:Subscribe(
	context: string, 
	action: string, 
	callback: (particle: IParticle, sender: Player?) -> nil
): () -> nil
```

To send data through Portal, you should use the `:Publish` method, like so:
```lua
Portal:Publish(context: string, action: string, data: any): nil
```

You can also create or retrieve a Context to perform operations on:
```lua
Portal:Context(context: string): IContext
```

You can create subscriptions, like so:
```lua
local subscription = Portal:Subscription(
	context: string, 
	action: string, 
	callback: (particle: IParticle, sender: Player?) -> nil?
): ISubscription
```

## Build Project
To build the place from scratch, use:
```bash
rojo build -o bin/portal.rbxlx targets/place.project.json
```

Next, open `bin/portal.rbxlx` in Roblox Studio (`start bin/portal.rbxlx` could work) and start the Rojo server:
```bash
rojo serve
```

For more help, check out [the Rojo documentation](https://rojo.space/docs).