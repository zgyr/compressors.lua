base64 = {}
local rep, byte, char = string.rep, string.byte, string.char

local abc = {[0] =
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
  'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
  'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
}

for i = 0, 63 do
  abc[abc[i]] = i
end

base64.encode = function(s)
  local pd = 2-(#s-1)%3
  s = (s..rep('\0', pd)):gsub('...', function(x)
    local a, b, c = byte(x, 1, 3)
    return abc[a>>2]..abc[(a&3)<<4|b>>4]..abc[(b&15)<<2|c>>6]..abc[c&63]
  end)
  return s:sub(1, #s-pd)..rep('=', pd)
end

base64.decode = function(s)
  local s, pd = s:gsub('=', 'A')
  s = s:gsub('....', function(x)
    local a, b, c, d = abc[x:sub(1, 1)],
    abc[x:sub(2, 2)],
    abc[x:sub(3, 3)],
    abc[x:sub(4, 4)]
    return char(a<<2|b>>4, ((b&15)<<4)|c>>2, ((c&3)<<6)|d)
  end)
  return s:sub(1, #s-pd)
end

return base64
