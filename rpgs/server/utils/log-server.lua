--[[
Project: VitaOnline
File: log-server.lua
Author(s):	MrX
]]--
Logger = {}
Logger.__index = Logger

function Logger.create(filepath)
	local nlog = {}
	
	if not fileExists(filepath) then
		fileClose(fileCreate(filepath)) -- hacky but efficient o_O
	end
	
	nlog.pFile = filepath
	setmetatable(nlog, Logger)
	return nlog
end

function Logger:addEntry(line)
	local handle = fileOpen(self.pFile)
	fileSetPos(handle, fileGetSize(handle))
	fileWrite(handle, timeformat().." "..line.."\n")
	fileClose(handle)
end


function timeformat()
 	local time = getRealTime(timestamp)
 
	time.year = time.year + 1900
	time.month = time.month + 1
 
	local datetime = { d = ("%02d"):format(time.monthday), h = ("%02d"):format(time.hour), i = ("%02d"):format(time.minute), m = ("%02d"):format(time.month), s = ("%02d"):format(time.second), y = tostring(time.year):sub(-2), Y = time.year }
	return "["..tostring(datetime.d).."."..tostring(datetime.m).."."..tostring(datetime.Y).." | "..tostring(datetime.h)..":"..tostring(datetime.i)..":"..tostring(datetime.s).."]"
end