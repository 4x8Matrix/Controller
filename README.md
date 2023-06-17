# Controller
The 'Controller' module is designed to represent a top-level client singleton, this module is designed to be used inside of the Infinity framework, however is a package of it's own in the case that the Infinity Framework isn't suitable for your application.

This project took inspiration from Knit's 'Controller' implementation & has attempted to improve the control flow designed in the controller itself.

> ⚠️ Each controller will inherit a 'Reporter' - these reporters stem from the '4x8matrix/Console' package and will allow developers to configure the schema, log level and have a better grip on the output these controllers will create.

## Examples
Brief documentation to go through the functionality:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Controller = require(ReplicatedStorage.Packages.Controller)

local ExampleController = Controller.new({
	Name = "ExampleController"
})

function ExampleController.Internal:Abc()
	self.Controller:Abc()
end

function ExampleController:Abc()
	self.Reporter:Debug("Hey, looks like the control flow is working!")
end

function ExampleController:Test()
	self.Internal:Abc()
end

ExampleController:Test()
```