local current = nil

util.AddNetworkString("converted_umsg")
util.AddNetworkString("converted_lua")

function umsg.Start(name, rcv)
	net.Start("converted_umsg")
	net.WriteString(name)
	
	local function func()
		if rcv then
			net.Send(rcv)
		else
			net.Broadcast()
		end
	end
	
	current = func
end

function umsg.String(a)
	net.WriteString(a)
end

function umsg.Float(a)
	net.WriteFloat(a)
end

function umsg.Bool(a)
	net.WriteBool(a)
end

function umsg.Vector(a)
	net.WriteVector(a)
end

function umsg.Angle(a)
	net.WriteAngle(a)
end

function umsg.Entity(a)
	net.WriteEntity(a)
end

function umsg.VectorNormal(a)
	net.WriteNormal(a)
end

function umsg.PoolString(a)
	util.AddNetworkString(a)
end

function umsg.Char(a)
	net.WriteInt(a, 8)
end

function umsg.Short(a)
	net.WriteInt(a, 16)
end

function umsg.Long(a)
	net.WriteInt(a, 32)
end

function umsg.End()
	if current then
		current()
	else
		net.Broadcast()
	end
end

function SendUserMessage(name, ply, ...)
	net.Start("converted_umsg")
	net.WriteString(name)
	
	for k, v in pairs({...}) do
		local t = type(v)
		
		if t == "string"  then
			net.WriteString(v)
		elseif IsEntity(v) then
			net.WriteEntity(v)
		elseif t == "number" then
			net.WriteInt(v, 32)
		elseif t == "Vector" then
			net.WriteVector(v)
		elseif t == "Angle" then
			net.WriteAngle(v)
		elseif t == "boolean" then
			net.WriteBool(v )
		end
	end
	
	if ply then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

function BroadcastLua(s)
	net.Start("converted_lua")
		net.WriteString(s)
	net.Broadcast()
end

local m = FindMetaTable("Player")

function m:SendLua(s)
	net.Start("converted_lua")
		net.WriteString(s)
	net.Send(self)
end