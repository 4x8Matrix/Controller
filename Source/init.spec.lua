return function()
	local Controller = require(script.Parent)

	local uniqueControllerName = "Controller_"
	local uniqueControllerIndex = 0

	beforeEach(function()
		uniqueControllerName = "Controller_" .. uniqueControllerIndex

		uniqueControllerIndex += 1
	end)

	describe("Instantiating a new 'Controller' object", function()
		it("Should be able to generate a new 'Controller' class", function()
			expect(function()
				local controller = Controller.new({
					Name = uniqueControllerName
				})

				expect(controller.Reporter).to.be.ok()
				expect(controller.Internal).to.be.ok()
				expect(controller.Controllers).to.be.ok()

				expect(controller.Name).to.equal(uniqueControllerName)
			end).never.to.throw()
		end)

		it("Should throw when given an invalid controller block", function()
			expect(function()
				Controller.new({
					Name = 123
				})
			end).to.throw()

			expect(function()
				Controller.new({ })
			end).to.throw()

			expect(function()
				Controller.new()
			end).to.throw()
		end)

		it("Should throw when attempting to create two controllers of the same name", function()
			expect(function()
				Controller.new({ Name = uniqueControllerName })
				Controller.new({ Name = uniqueControllerName })
			end).to.throw()
		end)

		it("Should be able to validate a new 'Controller' class", function()
			expect(function()
				local controller = Controller.new({
					Name = uniqueControllerName
				})

				expect(Controller.is(controller)).to.equal(true)
				expect(Controller.is(CFrame.new())).to.equal(false)
			end).never.to.throw()
		end)
	end)

	describe("'Controller' lifecycle methods", function()
		it("Should be able to invoke controller lifecycle methods", function()
			expect(function()
				local controller = Controller.new({
					Name = uniqueControllerName
				})

				function controller:Test()
					self.TestFlag = true
				end

				controller:InvokeLifecycle("Test")

				expect(controller.TestFlag).to.equal(true)
			end).never.to.throw()
		end)

		it("Should be able to return the result of an invoked lifecycle method", function()
			expect(function()
				local controller = Controller.new({
					Name = uniqueControllerName
				})

				function controller:Test()
					return 1
				end

				expect(controller:InvokeLifecycle("Test")).to.equal(1)
			end).never.to.throw()
		end)

		it("Should be able to compute varadic parameters", function()
			expect(function()
				local controller = Controller.new({
					Name = uniqueControllerName
				})

				function controller:Test(index, value)
					self[index] = value
				end

				controller:InvokeLifecycle("Test", "TestFlag", 10)

				expect(controller.TestFlag).to.equal(10)
			end).never.to.throw()
		end)
	end)
end