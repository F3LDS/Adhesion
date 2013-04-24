require 'class'

map = class:new()

function map:init()
	currentmap = {}
  storedcomplete = {}
  notdone = true
  notdone1 = true
  notdone2 = true
  notdone3 = true
  notdone4 = true
end


function map:load(file)

  --RESET
  currentmap = {}
  player = {}
  boxblocks = {}
  switches = {}
  colorblocks = {}
  walls = {}
  win = false
  activecount = 0
  notdone = true
  notdone1 = true
  notdone2 = true
  notdone3 = true
  notdone4 = true

	local file = io.open(file, "r");
	local innertemp = {}
	local final = {}
	local linenum = 0
	for line in file:lines() do -- For each line in the currentmap file
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
	currentmap = final
	love.graphics.setMode(#currentmap[1] * 30, #currentmap * 30)
  loadedmap = file
end

function map:win()
  colorblocks = {}
  notdone3 = true
  local file = io.open("win.dat", "r");
  local innertemp = {}
  local final = {}
  local linenum = 0
  for line in file:lines() do -- For each line in the currentmap file
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
  currentmap = final
end

function map:collideTest(x, y)
    for i,v in ipairs(player) do   
      if currentmap[(v["grid_y"] / 30) + y +1][(v["grid_x"] / 30) + x+1] == 1 then
          return false
      end
    end
    return true
end


function map:draw()
  love.graphics.setColor(0, 0, 255)
	for y=1, #currentmap do
    	for x=1, #currentmap[y] do
    	if currentmap[y][x] == 1 and notdone4 then
            table.insert(walls, {wall_x = x * 30 - 30, wall_y = y * 30 - 30})
        elseif currentmap[y][x] == 2  and notdone2 then
            table.insert(switches, {switch_x = x * 30 - 30, switch_y = y * 30 - 30, active = false})
        elseif currentmap[y][x] == 3 and notdone then
            table.insert(player, { grid_x = x * 30 - 30, grid_y = y * 30 - 30, act_x = x * 30 - 30, act_y = y * 30 - 30})
        elseif currentmap[y][x] == 4 and notdone1 then
            table.insert(boxblocks, {box_x = x * 30 - 30, box_y = y * 30 - 30, type = "build"})
        elseif currentmap[y][x] == 5 and notdone3 then
            table.insert(colorblocks, {box_x = x * 30 - 30, box_y = y * 30 - 30, r = 0, g = 0, b = 0, r_final = 255, g_final = 255, b_final = 255})
        end
      end
	end

	notdone = false
	notdone1 = false
	notdone2 = false
  notdone3 = false
  notdone4 = false

  for i,v in ipairs(walls) do
    --love.graphics.rectangle("fill", x * 30 - 30, y * 30 - 30 , 30, 30)
    love.graphics.rectangle("fill", v["wall_x"], v["wall_y"] , 30, 30)
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

  for i,v in ipairs(colorblocks) do
    love.graphics.setColor(v["r"], v["g"], v["b"])
    love.graphics.rectangle("fill", v["box_x"], v["box_y"], 30, 30)
  end

end