
HC = require 'hardoncollider'
--[[
=================================  _/_      /    =================================
=================================  /  __ __/ __  =================================
================================= (__(_)(_/_(_)  =================================

* Store all boxes to be adhered to player in a table
* Spawn new box from table and attach it when colliding with a piece
	* Then destroy piece? or attach existing to player?


]]
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
	player = {x=100, y=100, w=20, h=20}
	box = Collider:addRectangle(player["x"], player["y"], player["w"], player["h"])
	box2 = Collider:addRectangle(180, 180, 20, 20)
	box3 = Collider:addRectangle(-20, -20, 20, 20)
	boxes = {}
	reload = Collider:addRectangle(300, 300, 5, 10)
	notCollided = true
	bulletSpeed = 250
	bulletnum = 5
	bullets = {}
	grid = {}
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
	--[[for i,v in ipairs(boxes) do
		--v["dx"] = v["dx"] - v["dx"] * 1 * dt
		if v["dr"] == 1 then
			v["x"] = v["x"] + 20
		elseif v["dr"] == 2 then
			v["x"] = v["x"] - 20
		elseif v["dr"] == 3 then
			v["y"] = v["y"] - 20
		elseif v["dr"] == 4 then
			v["y"] = v["y"] + 20
		end
	end]]--
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
		box:move(0, -20)
		facing = 3
	end
	if key == "down" then
		box:move(0, 20)
		facing = 4
	end
	if key == "left" then
		box:move(-20, 0)
		facing = 2
	end
	if key == "right" then
 		box:move(20, 0)
		facing = 1
	end
end

function shoot()
	if bulletnum > 0 then
  --local startX = player["x"] + player["width"] / 2
  --local startY = player["y"] + player["height"] / 2
  --local startX = ball:center(x)
  -- local startY = ball:center(y)
		local startX, startY = box:center()
		local direction = facing
		local bulletDx = bulletSpeed
		local bulletDy = bulletSpeed
		table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy, dr = direction})
		bulletnum = bulletnum - 1
	end
end

function addBox()
	local startX, startY = box:center()
	local startX = startX - 10 --offset from our center because we want the box to be EXACTLY on top of the player
	local startY = startY - 10
	local direction = facing
	table.insert(boxes, {x = startX, y = startY, dr = direction}) --make a new entry containing the new boxes coords and direction
end

function on_collide(dt, shape_a, shape_b)
	if shape_a == box and shape_b == reload then
		bulletnum = bulletnum + 5
	elseif shape_a == box and shape_b == box2 or shape_b == box and shape_a == box2 then
		addBox()
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
	love.graphics.print("Boxes in scene = " .. #boxes, 0, 10)
	box:draw('fill')
	reload:draw('fill')
	box2:draw('fill')
	box3:draw('fill')
	love.graphics.setColor(255,255,255,255)
	for i,v in ipairs(bullets) do
		love.graphics.circle("fill", v["x"], v["y"], 3)
	end
	for i,v in ipairs(boxes) do --for each entry in the "boxes" table
		newBox = Collider:addRectangle(v["x"], v["y"], 20, 20) --create a rectangle at the stored data
		newBox:draw('fill')
	end
end