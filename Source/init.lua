-- // Imports
local Console = require(script.Parent.Console)
local Types = require(script.Types)

-- // Module
local Controller = {}

Controller.Type = "Controller"

Controller.Reporter = Console.new()

Controller.Internal = {}
Controller.Instances = {}
Controller.Interface = {}
Controller.Prototype = {}

-- // Internal functions
function Controller.Internal:Fill(object, index, value)
	if not object[index] then
		object[index] = value
	end
end

-- // Prototype functions
function Controller.Prototype:InvokeLifecycle(method, ...)
	if not self[method] then
		return
	end

	return self[method](self, ...)
end

function Controller.Prototype:ToString()
	return `{Controller.Type}<"{self.Name}">`
end

-- // Module functions
function Controller.Interface.new(controllerSource)
	Controller.Reporter:Assert(type(controllerSource) == "table", `Unable to cast {typeof(controllerSource)} to Table`)
	Controller.Reporter:Assert(type(controllerSource.Name) == "string", `Unable to cast field 'Name' {typeof(controllerSource.Name)} to Table`)
	Controller.Reporter:Assert(Controller.Instances[controllerSource.Name] == nil, `{controllerSource.Name} controller already exists`)

	if getmetatable(controllerSource) then
		Controller.Reporter:Warn(`Overwriting {controllerSource.Name} source table's metatable`)
	end

	controllerSource.Reporter = Console.new(controllerSource.Name)

	Controller.Internal:Fill(controllerSource, "Controllers", { })
	Controller.Internal:Fill(controllerSource, "Internal", {
		Controller = controllerSource,
		Controllers = controllerSource.Controllers
	})

	Controller.Instances[controllerSource.Name] = setmetatable(controllerSource, {
		__type = Controller.Type,
		__index = Controller.Prototype,
		__tostring = function(self)
			return self:ToString()
		end
	})

	return Controller.Instances[controllerSource.Name]
end

function Controller.Interface.is(object)
	if typeof(object) ~= "table" then
		return false
	end

	local objectMetatable = getmetatable(object)

	if not objectMetatable then
		return false
	end

	return objectMetatable.__type == Controller.Type
end

return Controller.Interface :: Types.Interface
