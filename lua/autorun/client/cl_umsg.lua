function usermessage:ReadAngle()
	return net.ReadAngle()
end

function usermessage:ReadVector()
	return net.ReadVector()
end

function usermessage:ReadVectorNormal()
	return net.ReadNormal()
end

function usermessage:ReadBool()
	return net.ReadBool()
end

function usermessage:ReadEntity()
	return net.ReadEntity()
end

function usermessage:ReadString()
	return net.ReadString()
end

function usermessage:ReadFloat()
	return net.ReadFloat()
end

function usermessage:ReadChar()
	return net.ReadInt(8)
end

function usermessage:ReadShort()
	return net.ReadInt(16)
end

function usermessage:ReadLong()
	return net.ReadInt(32)
end

net.Receive("converted_umsg", function()
	local f = net.ReadString()
	
	local fu = usermessage.fdata[f]
	local ofu = usermessage.GetTable()[f]
	
	if fu then
		fu(usermessage)
	elseif ofu then
		ofu(usermessage)
	else
		print("nofunc")
	end
end)

net.Receive("converted_lua", function()
	local s = net.ReadString()
	
	if s and s != "" then
		RunString(s)
	end
end)

usermessage.fdata = usermessage.fdata or {}

function usermessage.Hook(name, func)
	usermessage.fdata[name] = func
end