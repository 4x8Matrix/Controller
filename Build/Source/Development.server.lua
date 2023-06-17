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