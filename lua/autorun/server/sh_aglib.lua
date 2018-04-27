AGLib = {}
AGLib.version = "DEVELOPMENT"
AGLib.colors = {
	["Red"] = Color(244, 44, 44), 
	["Green"] = Color(44, 244, 44), 
	["Blue"] = Color(44, 44, 244), 
	["Pink"] = Color(244, 44, 244), 
	["Aqua"] = Color(44, 244, 244), 
	["Yellow"] = Color(244, 244, 44), 
	["Grey"] = Color(44, 44, 44), 
	["White"] = Color(244, 244, 244), 
}

function AGLib.randomChars(length_)
	if not length_ then length_ = 8 end
	local chars_ = {}
	for i=1, length_ do table.insert(chars_,  string.char(math.random(33, 126))) end
	local f_ = table.concat(chars_)
	table.Empty(chars_)
	table.remove(chars_)
	return f_
end

function AGLib.MsgC(...)
	_G.MsgC(unpack({...}))
	_G.MsgC("\r\n")
end

function AGLib.fromHex(string_)
	string_ = string.gsub(string_,  " ",  "")
    return (string.gsub(string_,  "..",  function(fromhex)
        return string.char(tonumber(fromhex,  16))
    end))
end

function AGLib.toHex(string_)
    return (string.gsub(string_,  ".",  function(tohex)
        return string.format("%02X", string.byte(tohex))
    end))
end

function AGLib.base64Encode(args)
	return util.Base64Encode(args)
end

function AGLib.base64Decode(args)
	local base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	data = string.gsub(args,  "[^"..base64Chars.."=]",  "")
	return (data:gsub(".",  function(x)
	    if (x == "=") then return "" end
	    local r, f="", (base64Chars:find(x)-1)
	        for i=6, 1, -1 do r=r..(f%2^i-f%2^(i-1)>0 and "1" or "0") end
	        return r;
	    end):gsub("%d%d%d?%d?%d?%d?%d?%d?",  function(x)
	        if (#x ~= 8) then return "" end
	        local c=0
	        for i=1, 8 do c=c+(x:sub(i, i)=="1" and 2^(8-i) or 0) end
	        return string.char(c)
	end))
end

function AGLib.CustomEncryption(string_)
	local stuff = string_
	local stuff = AGLib.toHex(stuff)
	local stuff = AGLib.toHex(stuff)
	local stuff = AGLib.toHex(stuff)
	local stuff = string.reverse(stuff)
	local stuff = AGLib.toHex(stuff)
	local stuff = string.reverse(stuff)
	local stuff = AGLib.base64Encode(stuff)
	file.Append("encryptlog.txt", "\r\n----------------\r\nString:\r\n"..string_.."\r\n\r\nEncrypted:\r\n"..stuff)
	return stuff
end

function AGLib.CustomDecryption(string_)
	local stuff = string_
	local stuff = AGLib.base64Decode(stuff)
	local stuff = string.reverse(stuff)
	local stuff = AGLib.fromHex(stuff)
	local stuff = string.reverse(stuff)
	local stuff = AGLib.fromHex(stuff)
	local stuff = AGLib.fromHex(stuff)
	local stuff = AGLib.fromHex(stuff)
	file.Append("encryptlog.txt", "\r\n----------------\r\nString:\r\n"..string_.."\r\n\r\nDecrypted:\r\n"..stuff)
	return stuff
end

print(AGLib.CustomDecryption([[MzMzMzMzNTMzMzMzMzM3MzMzMzMzMzYzMzMzMzMzMTMzMzMzMzM2MzMzNDMzMzUzMzMzMzMz
NjMzMzQzMzMyMzMzMzMzMzYzMzMzMzMzMjMzMzMzMzM2MzMzNDMzMzYzMzMzMzMzNzMzMzMz
MzM5MzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMz
MzMzMzMzMzMzMzMzOTM=]]))


function AGLib.LoadedMessage()
	AGLib.MsgC(
		AGLib.colors["Red"], 
		"--//--------------------------------\\\\--\n"..
		"    - AGLib is initializing now...."..
		"\n    - Running version: "..AGLib.version..
		"\n--\\\\--------------------------------//--"
	)

	for k,v in pairs(AGLib) do
		AGLib.MsgC(
			AGLib.colors["Red"], 
			"[AGLib] ",
			AGLib.colors["Yellow"],
			"Loaded variable/function: "..k
		)
	end

	AGLib.MsgC(
		AGLib.colors["Red"], 
		"[AGLib] ",
		AGLib.colors["Yellow"],
		"Successfully loaded!"
	)
end

AGLib.LoadedMessage()