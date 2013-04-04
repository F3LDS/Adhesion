--[[
*============= Adhesion ==============*
* Original Author: Alex Felder		  *
* Date of Creation: 2/20/2013 9:35 AM *
*=====================================*


 /$$$$$$           /$$   /$$    
|_  $$_/          |__/  | $$    
  | $$   /$$$$$$$  /$$ /$$$$$$  
  | $$  | $$__  $$| $$|_  $$_/  
  | $$  | $$  \ $$| $$  | $$    
  | $$  | $$  | $$| $$  | $$ /$$
 /$$$$$$| $$  | $$| $$  |  $$$$/
|______/|__/  |__/|__/   \___/  
                                
]]

HC = require 'hardoncollider'
shapes = require "hardoncollider.shapes"

function love.load()
	Collider = HC(100, on_collide)
	facing = 1
	playercoords = {x=100, y=100}
	playerblocks = {}
	boxblocks = {}
	--player = shapes.newPolygonShape(playercoords["x"], playercoords["y"], playercoords["x"] + 20, playercoords["y"], playercoords["x"], playercoords["y"] +20, playercoords["x"] + 20, playercoords["x"] + 20)
	player = love.graphics.rectangle("fill", playercoords["x"], playercoords["y"], 20, 20)
	--playerbb = Collider:addPolygon(getPlayerBB(leftx), getPlayerBB(lefty), getPlayerBB(downx), getPlayerBB(downy), getPlayerBB(rightx), getPlayerBB(righty), getPlayerBB(upx), getPlayerBB(upy))
	bulletSpeed = 250
	bulletnum = 5
	bullets = {}
	dtotal = 0


	playerblocks.insert((playercoords["x"],playercoords["y"]))
end
--[[

 /$$   /$$                 /$$             /$$                     /$$                                    
| $$  | $$                | $$            | $$                    | $$                                    
| $$  | $$  /$$$$$$   /$$$$$$$  /$$$$$$  /$$$$$$    /$$$$$$       | $$        /$$$$$$   /$$$$$$   /$$$$$$ 
| $$  | $$ /$$__  $$ /$$__  $$ |____  $$|_  $$_/   /$$__  $$      | $$       /$$__  $$ /$$__  $$ /$$__  $$
| $$  | $$| $$  \ $$| $$  | $$  /$$$$$$$  | $$    | $$$$$$$$      | $$      | $$  \ $$| $$  \ $$| $$  \ $$
| $$  | $$| $$  | $$| $$  | $$ /$$__  $$  | $$ /$$| $$_____/      | $$      | $$  | $$| $$  | $$| $$  | $$
|  $$$$$$/| $$$$$$$/|  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$$      | $$$$$$$$|  $$$$$$/|  $$$$$$/| $$$$$$$/
 \______/ | $$____/  \_______/ \_______/   \___/   \_______/      |________/ \______/  \______/ | $$____/ 
          | $$                                                                                  | $$      
          | $$                                                                                  | $$      
          |__/                                                                                  |__/     
]] 

function love.update(dt)
	dtotal = dtotal + dt
	Collider:update(dt)

	for i,v in ipairs(bullets) do
		if v["dr"] == 1 then
			v["x"] = v["x"] + (v["dx"] * dt)
		elseif v["dr"] == 2 then
			v["x"] = v["x"] - (v["dx"] * dt)
		elseif v["dr"] == 3 then
			v["y"] = v["y"] - (v["dy"] * dt)
		elseif v["dr"] == 4 then
			v["y"] = v["y"] + (v["dy"] * dt)
		end
	end
end

--[[

 /$$$$$$                                 /$$    
|_  $$_/                                | $$    
  | $$   /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$  
  | $$  | $$__  $$ /$$__  $$| $$  | $$|_  $$_/  
  | $$  | $$  \ $$| $$  \ $$| $$  | $$  | $$    
  | $$  | $$  | $$| $$  | $$| $$  | $$  | $$ /$$
 /$$$$$$| $$  | $$| $$$$$$$/|  $$$$$$/  |  $$$$/
|______/|__/  |__/| $$____/  \______/    \___/  
                  | $$                          
                  | $$                          
                  |__/                          

]]

function love.keypressed(key)
	if key == " " then
		shoot()
	end
	if key == "up" then
		--player:move(0, -20)
		playercoords["y"] = playercoords["y"] - 20
		facing = 3
	end
	if key == "down" then
		--player:move(0, 20)
		playercoords["y"] = playercoords["y"] + 20
		facing = 4
	end
	if key == "left" then
		--player:move(-20, 0)
		playercoords["x"] = playercoords["x"] - 20
		facing = 2
	end
	if key == "right" then
 		--player:move(20, 0)
 		playercoords["x"] = playercoords["x"] + 20
		facing = 1
	end
end

--function table.Compare( tbl1, tbl2 )
--    for k, v in pairs( tbl1 ) do
--        if ( tbl2[k] != v ) then return false end
 --   end
   -- for k, v in pairs( tbl2 ) do
    --    if ( tbl1[k] != v ) then return false end
   -- end
   -- return true
--end

--[[

  /$$$$$$            /$$ /$$ /$$           /$$                    
 /$$__  $$          | $$| $$|__/          |__/                    
| $$  \__/  /$$$$$$ | $$| $$ /$$  /$$$$$$$ /$$  /$$$$$$  /$$$$$$$ 
| $$       /$$__  $$| $$| $$| $$ /$$_____/| $$ /$$__  $$| $$__  $$
| $$      | $$  \ $$| $$| $$| $$|  $$$$$$ | $$| $$  \ $$| $$  \ $$
| $$    $$| $$  | $$| $$| $$| $$ \____  $$| $$| $$  | $$| $$  | $$
|  $$$$$$/|  $$$$$$/| $$| $$| $$ /$$$$$$$/| $$|  $$$$$$/| $$  | $$
 \______/  \______/ |__/|__/|__/|_______/ |__/ \______/ |__/  |__/
                                                                  
]]


function adhesion()
end

--[[

 /$$$$$$$                                  
| $$__  $$                                 
| $$  \ $$  /$$$$$$  /$$$$$$  /$$  /$$  /$$
| $$  | $$ /$$__  $$|____  $$| $$ | $$ | $$
| $$  | $$| $$  \__/ /$$$$$$$| $$ | $$ | $$
| $$  | $$| $$      /$$__  $$| $$ | $$ | $$
| $$$$$$$/| $$     |  $$$$$$$|  $$$$$/$$$$/
|_______/ |__/      \_______/ \_____/\___/ 
                                         
]]
function love.draw()
	love.graphics.print("Coordinates: (" .. playercoords["x"]  .. ", " .. playercoords["y"] .. ")", 0, 0)
	love.graphics.print("Table Test: " .. playerblocks, 0, 0)
	--love.graphics.setColor(255,255,255,0)
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", playercoords["x"], playercoords["y"], 20, 20)
	for i,v in ipairs(bullets) do
		love.graphics.circle("fill", v["x"], v["y"], 3)
	end
end