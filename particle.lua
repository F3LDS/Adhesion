require 'class'

particle = class:new()

function particle:init()
	self.x = 0
   	self.y = 0
   	self.x1 = 0
   	self.y1 = 0

	i = love.graphics.newImage("particle.png")
  
	p1 = love.graphics.newParticleSystem(i, 256)
 	p1:setEmissionRate          (100)
 	p1:setLifetime              (.1)
 	p1:setParticleLife          (.1)
 	p1:setPosition              (0, 0)
  	p1:setDirection             (-1.570796327)
  	p1:setSpread                (1)
  	p1:setSpeed                 (200, 200)
  	p1:setGravity               (0)
  	p1:setRadialAcceleration    (10)
  	p1:setTangentialAcceleration(0)
  	p1:setSizes                 (2)
  	p1:setSizeVariation         (0.5)
  	p1:setRotation              (0)
  	p1:setSpin                  (0)
  	p1:setSpinVariation         (0)
  	p1:setColors                (200, 200, 255, 240, 255, 255, 255, 10)
  	p1:stop();--this stop is to prevent any glitch that could happen after the particle system is created

  	p2 = love.graphics.newParticleSystem(i, 256)
  	p2:setEmissionRate          (100)
  	p2:setLifetime              (.1)
  	p2:setParticleLife          (.1)
  	p2:setPosition              (0, 0)
  	p2:setDirection             (1.570796327)
  	p2:setSpread                (1)
  	p2:setSpeed                 (200, 200)
  	p2:setGravity               (0)
  	p2:setRadialAcceleration    (10)
  	p2:setTangentialAcceleration(0)
  	p2:setSizes                 (2)
  	p2:setSizeVariation         (0.5)
  	p2:setRotation              (0)
  	p2:setSpin                  (0)
  	p2:setSpinVariation         (0)
  	p2:setColors                (200, 200, 255, 240, 255, 255, 255, 10)
  	p2:stop();--this stop is to prevent any glitch that could happen after the particle system is created
end

function particle:update(dt)
	p1:update(dt)
  	p2:update(dt)
end

function particle:emit(x, y, x1, y1)
	self.x = x
   	self.y = y
   	self.x1 = x1
   	self.y1 = y1
   	print("EMITTING at " .. self.x .. " " .. self.y .. " and " .. self.x1 .. " " .. self.y1)
   	p1:start()
   	p2:start()
end

function particle:direction(direction)
	if direction == "upanddown" then
		p1:setDirection(-1.57079633)
		p2:setDirection(1.57079633)
	elseif direction == "leftandright" then
		p1:setDirection(3.14159265)
		p2:setDirection(0)
	end
end

function particle:draw()
	love.graphics.draw(p1, self.x, self.y)
  	love.graphics.draw(p2, self.x1, self.y1)
end