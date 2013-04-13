--[[
*============= Adhesion ==============*
* Original Author: Alex Felder		  *
* Date of Creation: 2/30/3013 9:35 AM *
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
function love.load()
	facing = 1
    player = {
        grid_x = 60,
        grid_y = 60,
        act_x = 60,
        act_y = 60,
        speed = 30
    }
	boxblocks = {}
	dtotal = 0

  loadMap("level1.dat")

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

    player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
    player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)

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
		if testMap(0, -1) then
			player.grid_y = player.grid_y - 30
			facing = 3
		end
	end
	if key == "down" then
		if testMap(0, 1) then
			player.grid_y = player.grid_y + 30
			facing = 4
		end
	end
	if key == "left" then
		if testMap(-1, 0) then
			player.grid_x = player.grid_x - 30
			facing = 2
		end
	end
	if key == "right" then
		if testMap(1, 0) then
 			player.grid_x = player.grid_x + 30
			facing = 1
		end
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

function testMap(x, y)
    if map[(player.grid_y / 30) + y][(player.grid_x / 30) + x] == 1 then
        return false
    end
    return true
end

function loadMap(mapfile)
  local file = io.open(mapfile, "r");
  local innertemp = {}
  local final = {}
  local linenum = 0
  for line in file:lines() do -- For each line in the map file
    linenum = linenum + 1
    stringline = line -- store it in the stringline variable
    for i = 1, string.len(stringline) do -- for each character in each line
      value = string.sub(stringline, i, i) -- store it in the value variable
      innertemp[#innertemp + 1] = tonumber(value, 10)
      if #innertemp == string.len(stringline) then
            final[#final + 1] = innertemp
            innertemp = {}
      end
    end
  end
map = final
end

function printTable(t)

    function printTableHelper(t, spacing)
        for k,v in pairs(t) do
            print(spacing..tostring(k), v)
            if (type(v) == "table") then 
                printTableHelper(v, spacing.."\t")
            end
        end
    end

    printTableHelper(t, "");
end

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
	--love.graphics.print("Table Test: " .. didPass .. " " .. passNum, 0, 0)
	
	love.graphics.setColor(0, 0, 255)

	for y=1, #map do
     	for x=1, #map[y] do
          if map[y][x] == 1 then
            love.graphics.rectangle("fill", x * 30, y * 30, 30, 30)
          elseif map[y][x] == 2 then
            love.graphics.setColor(255, 0, 0)
            love.graphics.rectangle("fill", x * 30, y * 30, 30, 30)
            love.graphics.setColor(0, 0, 255)
          end
      end
  end

  love.graphics.setColor(255,255,255,255)
  love.graphics.rectangle("fill", player.act_x, player.act_y, 30, 30)
end