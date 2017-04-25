

rotary.setup( 0, 3, 4, 5)
posC = rotary.getpos(0)

print( posC )


-- rotary.on( 0, rotary.ALL, function( type, pos, when )
-- 	print( "Position=" .. pos .. " event type=" .. type .. " time=" .. when )
-- end)

rotary.on( 0, rotary.TURN, function( type, pos, when )
	print( "TURN Position=" .. pos .. " event type=" .. type .. " time=" .. when )
    if pos > posC then
        print( "TURN RIGHT" )
    elseif pos < posC then
        print( "TURN LEFT" )
    else
        print( "TURN SAME" )
    end

    posC = pos
end)

rotary.on( 0, rotary.CLICK, function( type, pos, when )
	print( "CLICK Position=" .. pos .. " event type=" .. type .. " time=" .. when )
end)

rotary.on( 0, rotary.PRESS, function( type, pos, when )
	print( "PRESS Position=" .. pos .. " event type=" .. type .. " time=" .. when )
end)
