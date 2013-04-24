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
require 'particle'
require 'collision'

function love.load()
  playerclass = playerclass:new()
  particle = particle:new()
  playerclass:setPosition(60,30)
  map1 = map:new()
	facing = 1
  playerspeed = 30 
  player = {}
	boxblocks = {}
  switches = {}
  colorblocks = {}
	dtotal = 0
  win = false
  test = 0
  activecount = 0
  debug = false
  loadedmap = "none"

  map1:load("menu.dat")
  loadedmap = "menu"



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
    v["act_y"] = round(v["act_y"]) - ((round(v["act_y"]) - v["grid_y"]) * playerspeed * dt)
    v["act_x"] = round(v["act_x"]) - ((round(v["act_x"]) - v["grid_x"]) * playerspeed * dt)
  end

  for i,v in ipairs(colorblocks) do
    v["r"] = round(v["r"]) - ((round(v["r"]) - v["r_final"]) * 5 * dt)
    v["g"] = round(v["g"]) - ((round(v["g"]) - v["g_final"]) * 5 * dt)
    v["b"] = round(v["b"]) - ((round(v["b"]) - v["b_final"]) * 5 * dt)
  end

  if dtotal >= .1 then
      dtotal = round(dtotal - .1)
      for i,v in ipairs(colorblocks) do
        v["r_final"] = math.random(0, 255)
        v["g_final"] = math.random(0, 255)
        v["b_final"] = math.random(0, 255)
      end
  end

  if (loadedmap == "menu") then
    collision:menu()
  else
    collision:switches()
  end

  collision:blocks()
  particle:update(dt)

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
  elseif key == "escape" then
    map1:load("menu.dat")
    loadedmap = "menu"
  elseif key == "o" then
    map1:load("level1.dat")
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

  particle:draw()
  playerclass:draw()
  map1:draw()

  
  for i,v in ipairs(colorblocks) do
    love.graphics.setColor(v["r"], v["g"], v["b"])
    love.graphics.rectangle("fill", v["box_x"], v["box_y"], 30, 30)
  end

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

  if win == true then
    love.graphics.print("WINNER", 120, 275, 50, 10)
    love.graphics.print("WIN", 0, 30)
  end

  if (debug == true) then
    for i,v in ipairs(player) do
      local pos = 0
      love.graphics.print("Players: " .. #player .. "  Blocks: " .. #boxblocks .. " Switches: " .. #switches .. " Colorblocks: "..#colorblocks, 0, 0)
      love.graphics.print("Player act_x: " .. v["act_x"] .. "  Player act_y: " .. v["act_y"], 300, 0)
      love.graphics.print("Tick Time: " .. dtotal, 0, 15)
    end
  end
end