
rotary.setup( 0, 5, 6, 7)

print( rotary.getpos(0) )


-- rotary.on( 0, rotary.ALL, function( type, pos, when )
-- 	print( "Position=" .. pos .. " event type=" .. type .. " time=" .. when )
-- end)

rotary.on( 0, rotary.TURN, function( type, pos, when )
	print( "Position=" .. pos .. " event type=" .. type .. " time=" .. when )
end)

rotary.on( 0, rotary.CLICK, function( type, pos, when )
	print( "Position=" .. pos .. " event type=" .. type .. " time=" .. when )
end)

rotary.on( 0, rotary.PRESS, function( type, pos, when )
	print( "Position=" .. pos .. " event type=" .. type .. " time=" .. when )
end)
