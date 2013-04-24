require 'class'

collision = class:new()

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


function collision:init()
	switchcounter = 0
end

function collision:blocks() 
  for i, v in pairs( player ) do
    for j, w in pairs( boxblocks ) do
      --Check Left
      if ( w["box_x"] - 30 == round(v["act_x"]) ) and ( w["box_y"] == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
        particle:direction("upanddown")
        particle:emit(round(v["act_x"])+30,round(v["act_y"]),round(v["act_x"])+30,round(v["act_y"])+30)
      end
      --Check Right
      if ( w["box_x"] + 30 == round(v["act_x"]) ) and ( w["box_y"] == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
        particle:direction("upanddown")
        particle:emit(round(v["act_x"]),round(v["act_y"]),round(v["act_x"]),round(v["act_y"])+30)
      end
      --Check Up
      if ( w["box_x"] == round(v["act_x"]) ) and ( w["box_y"] + 30 == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
        particle:direction("leftandright")
        particle:emit(round(v["act_x"]),round(v["act_y"]),round(v["act_x"])+30,round(v["act_y"]))
      end
      --Check Down
      if ( w["box_x"] == round(v["act_x"]) ) and ( w["box_y"] - 30 == round(v["act_y"]) ) then
        table.insert(player, { grid_x = w["box_x"], grid_y = w["box_y"], act_x = w["box_x"], act_y = w["box_y"]})
        table.remove(boxblocks, j)
        particle:direction("leftandright")
        particle:emit(round(v["act_x"]),round(v["act_y"])+30,round(v["act_x"])+30,round(v["act_y"])+30)
      end
    end
  end
end

function collision:menu()
  for i, v in pairs( player ) do
    for j, w in pairs( switches ) do
      if ( w["switch_y"] == round(v["act_y"]) ) and ( w["switch_x"] == round(v["act_x"]) ) then
        if (j == 2) then
        	map:load("level1.dat")
        end
        if (j == 4) then
          map:load("level2.dat")
        end
        if (j == 5) then
          map:load("level3.dat")
        end
        if (j == 6) then
          map:load("level4.dat")
        end
      end
    end
  end
end

function collision:switches()
  for i, v in pairs( player ) do
    for j, w in pairs( switches ) do
      if ( w["switch_y"] == round(v["act_y"]) ) and ( w["switch_x"] == round(v["act_x"]) ) then
        w["active"] = true
      end
    end
  end
  switchCheck()
  for j, w in pairs( switches ) do
    w["active"] = false
  end
end

function switchCheck()
  if (#switches > 0) then
    for i, v in pairs( switches ) do
      if (v["active"] == true) then
        activecount = activecount + 1
      end
    end
    if (activecount == #switches) then
      win = true
      if runonce == false then
        map:win()
      end
      runonce = true
      switchcounter = switchcounter + 1
      if switchcounter > 100 then
      	map:load("menu.dat")
      	loadedmap = "menu"
      end
    else
      runonce = false
      win = false
      switchcounter = 0
    end
    activecount = 0
  end
end