
HC = require 'hardoncollider'
--[[

 /$$$$$$           /$$   /$$    
|_  $$_/          |__/  | $$    
  | $$   /$$$$$$$  /$$ /$$$$$$  
  | $$  | $$__  $$| $$|_  $$_/  
  | $$  | $$  \ $$| $$  | $$    
  | $$  | $$  | $$| $$  | $$ /$$
 /$$$$$$| $$  | $$| $$  |  $$$$/
|______/|__/  |__/|__/   \___/  
                                
]]

function love.load()
	Collider = HC(100, on_collide)
	circx = 300
	circy = 300
	facing = 1
	playercoords = {x=100, y=100, w=20, h=20}
	player = Collider:addPolygon(playercoords["x"], playercoords["y"], playercoords["x"] + 20, playercoords["y"], playercoords["x"], playercoords["y"] +20, playercoords["x"] + 20, playercoords["x"] + 20)
	reload = Collider:addRectangle(300, 300, 5, 10)
	bulletSpeed = 250
	bulletnum = 5
	bullets = {}
	dtotal = 0
	test = "nope"
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
		--v["dx"] = v["dx"] - v["dx"] * 1 * dt
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
		player:move(0, -20)
		facing = 3
	end
	if key == "down" then
		player:move(0, 20)
		facing = 4
	end
	if key == "left" then
		player:move(-20, 0)
		facing = 2
	end
	if key == "right" then
 		player:move(20, 0)
		facing = 1
	end
end

function shoot()
	if bulletnum > 0 then
		local startX, startY = box:center()
		local direction = facing
		local bulletDx = bulletSpeed
		local bulletDy = bulletSpeed
		table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy, dr = direction})
		bulletnum = bulletnum - 1
	end
end

function on_collide(dt, shape_a, shape_b)
	if shape_a == player and shape_b == reload or shape_b == player and shape_a == reload then
		bulletnum = bulletnum + 5
	end
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
	love.graphics.print("Bullets Remaining = " .. bulletnum, 0, 0)
	reload:draw('fill')
	player:draw('fill')
	love.graphics.setColor(255,255,255,255)
	for i,v in ipairs(bullets) do
		love.graphics.circle("fill", v["x"], v["y"], 3)
	end
end