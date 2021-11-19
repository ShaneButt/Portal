# portal
Built with [Rojo](https://github.com/rojo-rbx/rojo) 7.0.0-rc.1.

Portal is a Networking frameworking implementing a Publisher-Subscriber model. It aims to stand next to notable frameworks such as Postal.js. It also takes inspiration from a alternative implementation of Postal written in Lua, [Ropost]()

Portal aims to make Networking simple by providing two core methods:
```lua
Portal:Subscribe(context: string, action, string, callback: () -> ()): () -> ()
Portal:Publish(context: string, action: string, data: any): () -> ()
```

You can create contexts like so:
```lua
Portal:Context(context: string)
```

You can create subscriptions, like so:
```lua
local listener = Portal:Subscription()
```

## Getting Started
To build the place from scratch, use:

```bash
rojo build -o bin/portal.rbxlx targets/place.project.json
```

Next, open `bin/portal.rbxlx` in Roblox Studio (`start bin/portal.rbxlx` could work) and start the Rojo server:

```bash
rojo serve
```

For more help, check out [the Rojo documentation](https://rojo.space/docs).