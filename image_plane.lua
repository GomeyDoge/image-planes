local SIZE_X, SIZE_Y = 256, 256
local sw, sh = ScrW(), ScrH()
local centerX, centerY = sw / 2, sh / 2
local centerVec = Vector(centerX, centerY, 0)
local col = Color(40, 40, 40)

local cat = Material( "data/funnied.jpg" )

local function drawRotatedImage( mat, rot )
	local x, y, z = rot:Unpack()
	surface.SetDrawColor(color_white)
	surface.SetMaterial( mat )

	local m = Matrix()

	local squishX = math.rad(x)
	local squishY = math.rad(y)

	m:Translate( centerVec )
	m:Rotate( Angle( squishX, squishY, 0 ) )
	m:Translate( -centerVec )

	cam.PushModelMatrix( m )
		surface.DrawTexturedRect( centerX - (SIZE_X * (1 - squishX) / 2), centerY - (SIZE_Y * (1 - squishY) / 2), SIZE_X * (1 - squishX), SIZE_Y * (1 - squishY) )
	cam.PopModelMatrix()
end

local ang = 0
hook.Add( "HUDPaint", "BoxStuff", function()
	drawRotatedImage( cat, Vector( ang, 0, 0 ) )
end )

concommand.Add("rm", function() -- Debug Command
	ang = (ang + 5) % 360
	print(ang)
end )
