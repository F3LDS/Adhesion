require 'class'

playerclass = class:new()

function playerclass:init()
   self.x = 0
   self.y = 0
end

function playerclass:setPosition(x, y)
   self.x = x
   self.y = y
end

function playerclass:draw()
   love.graphics.rectangle("fill", self.x, self.y, 30, 30)
end