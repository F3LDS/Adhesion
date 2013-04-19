require 'class'

map = class:new()

function playerclass:init()
	currentmap = {}
end


function map:load(file)
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
    	if currentmap[y][x] == 1 then
        	love.graphics.rectangle("fill", x * 30 - 30, y * 30 - 30 , 30, 30)
        elseif currentmap[y][x] == 2 then
            table.insert(switches, {switch_x = x * 30 - 30, switch_y = y * 30 - 30, type = "momentary"})
        elseif currentmap[y][x] == 3 and notdone then
            table.insert(player, { grid_x = x * 30 - 30, grid_y = y * 30 - 30, act_x = x * 30 - 30, act_y = y * 30 - 30})
        elseif currentmap[y][x] == 4 and notdone1 then
            table.insert(boxblocks, {box_x = x * 30 - 30, box_y = y * 30 - 30, type = "build"})
        end
      end
	end
	notdone = false
	notdone1 = false
	notdone2 = false

end