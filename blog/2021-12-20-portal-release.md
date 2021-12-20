# Portal Release!

As of today, Portal is available for public use; it's official. We're deciding to start things off at a comfortable version of 0.5.0-rc.1, the idea is to ensure everything works as intended and to fix things along the way and eventually make progress to 1.0.0 for the first stable release of Portal.

As it stands, Portal's API is pretty stable, I can't see it changing much if at all before 1.0.0.

## Roadmap

- Work with Portal and port Arvorian Industries gun scripts to use Portal instead of RemoteEvents.
- Fix bugs during the porting of AI gun scripts.
- Research and potentially provide RemoteFunction and Signal support.
- Finish SimpleRodux and TypeCheck middleware.
- Finish up the Demo place and include an example of defining Contexts.

## Changes since 0.2.0-beta

Boy, this is a long one. 

- We have a *metric ton* of Luau type coverage improvements.
- A boat-load of fixes and improvements to the Wormhole, Context, and Subscription classes.
- Fleshed out Middleware & support for custom middleware.
- Runtime type-checking and improvements to Portal Types.
- Fixes to front-facing API.

- Source Docs & auto-generated API docs using [Moonwave](https://upliftgames.github.io/moonwave/docs/intro).
- Documentation for Installation, Usage, and more, built using Moonwave.
- Published to Wally under `shanebutt/portal@0.5.0`.