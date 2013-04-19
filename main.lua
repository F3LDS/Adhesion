--[[
*============= Adhesion ==============*
*    Original Author: Alex Felder		  *
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

require 'playerclass'
require 'map'

function love.load()
  playerclass = playerclass:new()
  playerclass:setPosition(60,30)
  map1 = map:new()
	facing = 1
  playerspeed = 30 
  player = {}
	boxblocks = {}
  switches = {}
	dtotal = 0
  notdone = true
  notdone1 = true


  --loadMap("level1.dat")
  map1:load("level1.dat")

  --love.graphics.setMode(#map[1] * 30, #map * 30)

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

  for i,v in ipairs(player) do
    v["act_y"] = v["act_y"] - ((v["act_y"] - v["grid_y"]) * playerspeed * dt)
    v["act_x"] = v["act_x"] - ((v["act_x"] - v["grid_x"]) * playerspeed * dt)

    if (round(v["act_y"]) == v["grid_y"]) and (round(v["act_x"]) == v["grid_x"]) then
      notmoving = true
    else
      notmoving = false
    end

  end



  table.Compare()

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
    if map1:collideTest(0, -1) then
      for i,v in ipairs(player) do
        v["grid_y"] = v["grid_y"] - 30
      end
			facing = 3
		end
	elseif key == "down" then
    if map1:collideTest(0, 1) then
      for i,v in ipairs(player) do
        v["grid_y"] = v["grid_y"] + 30
      end
			facing = 4
		end
	elseif key == "left" then
    if map1:collideTest(-1, 0) then
      for i,v in ipairs(player) do
        v["grid_x"] = v["grid_x"] - 30
      end
			facing = 2
		end
	elseif key == "right" then
    if map1:collideTest(1, 0) then
      for i,v in ipairs(player) do
        v["grid_x"] = v["grid_x"] + 30
      end
			facing = 1
		end
  end
end

function table.Compare()
  for j, w in pairs( boxblocks ) do
    for i, v in pairs( player ) do
      --Check Left
      if ( w["box_x"] - 30 == round(v["act_x"]) ) and ( w["box_y"] == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
      end
      --Check Right
      if ( w["box_x"] + 30 == round(v["act_x"]) ) and ( w["box_y"] == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
      end
      --Check Up
      if ( w["box_x"] == round(v["act_x"]) ) and ( w["box_y"] + 30 == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
      end
      --Check Down
      if ( w["box_x"] == round(v["act_x"]) ) and ( w["box_y"] - 30 == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
      end
    end
  end
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
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
	
  playerclass:draw()
  map1:draw()

  love.graphics.setColor(0, 0, 255)
	--[[for y=1, #map do
     	for x=1, #map[y] do
          if map[y][x] == 1 then
            love.graphics.rectangle("fill", x * 30 - 30, y * 30 - 30 , 30, 30)
          elseif map[y][x] == 2 then
            table.insert(switches, {switch_x = x * 30 - 30, switch_y = y * 30 - 30, type = "momentary"})
          elseif map[y][x] == 3 and notdone then
            table.insert(player, { grid_x = x * 30 - 30, grid_y = y * 30 - 30, act_x = x * 30 - 30, act_y = y * 30 - 30})
          elseif map[y][x] == 4 and notdone1 then
            table.insert(boxblocks, {box_x = x * 30 - 30, box_y = y * 30 - 30, type = "build"})
          end
      end
  end]]
 notdone = false
 notdone1 = false
 notdone2 = false


  --Box Blocks
  love.graphics.setColor(0, 255, 0)
  for i,v in ipairs(boxblocks) do
    love.graphics.rectangle("fill", v["box_x"], v["box_y"], 30, 30)
  end

  --Switches
  love.graphics.setColor(255,0,0)
  for i,v in ipairs(switches) do
    love.graphics.rectangle("fill", v["switch_x"], v["switch_y"], 30, 30)
  end

  --Player Pieces
  love.graphics.setColor(255,255,255)
  for i,v in ipairs(player) do
    love.graphics.rectangle("fill", v["act_x"], v["act_y"], 30, 30)
  end




  for i,v in ipairs(player) do
    love.graphics.print("actx: " .. round(v["act_x"]) .. "  acty: " .. round(v["act_y"]) .. " # of Blocks: " .. #boxblocks, 0, 0)
  end
end