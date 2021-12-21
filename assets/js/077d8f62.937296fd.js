"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[517],{64349:function(e){e.exports=JSON.parse('{"functions":[{"name":"load","desc":"Instantiates a new Middleware and loads the given middleware into its pipeline.","params":[{"name":"middleware","desc":"A list of middleware, by name, to be loaded into the Middleware\'s pipeline.","lua_type":"{string}"}],"returns":[{"desc":"","lua_type":"Middleware"}],"function_type":"static","source":{"line":26,"path":"src/Wormhole/Middleware/init.lua"}},{"name":"Warp","desc":"Transforms the data being sent and sends it through the middleware\'s pipeline.","params":[{"name":"data","desc":"The data being sent through the middleware pipeline.","lua_type":"{[string]: any}"},{"name":"portal","desc":"A dictionary with two fields: Context and Action which are the names of the Context-Action being targeted.","lua_type":"{[string]: string}"},{"name":"pipeline","desc":"A list of middleware functions that take data and portal as arguments.","lua_type":"{ (data: { [string]: any}, portal: { [string]: string }) -> IParticle }"}],"returns":[{"desc":"The resulting Particle, after going through the middleware and being Charged.","lua_type":"IParticle"}],"function_type":"method","source":{"line":57,"path":"src/Wormhole/Middleware/init.lua"}}],"properties":[],"types":[],"name":"Middleware","desc":"To be documented.","source":{"line":13,"path":"src/Wormhole/Middleware/init.lua"}}')}}]);