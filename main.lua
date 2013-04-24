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

require 'map'
require 'particle'
require 'collision'

function love.load()
  particle = particle:new()   -- Create an instance of the particle class
  map1 = map:new()            -- Create an instance of the map class
	facing = 1                  -- a variable used to tell which direction the player just moved in
  playerspeed = 30            -- The multiplier to determine the player's sliding speed
  player = {}                 -- A table in which we will store each of our players and their attributes
	boxblocks = {}              -- A table to store all of the collectible blocks in the scene
  switches = {}               -- A table to store all of the switches in the scene
  colorblocks = {}            -- Used to store the multicolor blocks used in the main menu
  walls = {}
	dtotal = 0                  
  win = false                 -- Boolean describing whether the level has been won
  activecount = 0             --
  debugme = false             -- Set to true in order to see debugging information
  loadedmap = "none"          -- My version of a gamestate. This will always equal the name of the currently loaded leve



  map1:load("menu.dat")       -- Load the menu.dat level file for our menu scene
  loadedmap = "menu"          -- And set our "game state" to menu



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
  if win == false then
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
    elseif key == "r" then
      map:win()
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
  map1:draw()

  if (debugme == true) then
    for i,v in ipairs(player) do
      local pos = 0
      love.graphics.print("Players: " .. #player .. "  Blocks: " .. #boxblocks .. " Switches: " .. #switches .. " Colorblocks: "..#colorblocks, 0, 0)
      love.graphics.print("Player act_x: " .. v["act_x"] .. "  Player act_y: " .. v["act_y"], 300, 0)
      love.graphics.print("Tick Time: " .. dtotal, 0, 15)
    end
  end
end