-- load credentials, 'SSID' and 'PASSWORD' declared and initialize in there
dofile( "credentials.lua" )

CMDFILE			= "ping.lua"	-- File that is executed after connection
NUMWIFITRIES	= 0				-- Counter of tries to connect to WiFi
MAXWIFITRIES	= 200			-- Maximum number of WIFI retries while waiting for connection

function startup()
	if file.open( "init.lua" ) == nil then
		print( "init.lua deleted or renamed" )
	else
		print( "Running" )
		file.close( "init.lua" )

		-- Call our command file. Note: if you foul this up you'll brick the device!
		-- dofile( CMDFILE )
		-- fileFunction()
	end
end

function launch()
	print( "WiFi connection established, IP address: " .. wifi.sta.getip() )
	print( "You have 3 seconds to abort" )
	print( "Waiting..." )
	tmr.alarm( 1, 3000, 0, startup )
end

function checkWIFI()
	if ( NUMWIFITRIES > MAXWIFITRIES ) then
		print( "Sorry. Not able to connect" )
	else
		ipAddr = wifi.sta.getip()
		if ( ( ipAddr ~= nil ) and ( ipAddr ~= "0.0.0.0" ) ) then
			launch()
		else
			-- Reset alarm again
			tmr.alarm( 0 , 2500 , 0 , checkWIFI )
			print( "Checking WIFI..." .. NUMWIFITRIES )
			NUMWIFITRIES = NUMWIFITRIES + 1
		end
	end
end


print( "-- Starting up! " )

-- Lets see if we are already connected by getting the IP
ipAddr = wifi.sta.getip()
if ( ( ipAddr == nil ) or ( ipAddr == "0.0.0.0" ) ) then
	-- We aren't connected, so let's connect
	print( "Configuring WIFI...." )
	wifi.setmode( wifi.STATION )
	wifi.sta.config( SSID , APPWD )
	print( "Waiting for connection" )
	tmr.alarm( 0, 2500, 0, checkWIFI )
else
	-- We are connected, so just run the startup code.
	launch()
end
