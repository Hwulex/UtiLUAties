-- From https://odd-one-out.serek.eu/esp8266-nodemcu-dht22-mqtt-deep-sleep/

-- MQTT connect script with deep sleep
-- Remember to connect GPIO16 and RST to enable deep sleep

--############
--# Settings #
--############

--- MQTT ---
mqtt_broker_ip = "192.168.1.66"     
mqtt_broker_port = 1883
mqtt_username = ""
mqtt_password = ""
mqtt_client_id = ""

--- WIFI ---
wifi_SSID = "wifi-Name"
wifi_password = "wifi-Password"
-- wifi.PHYMODE_B 802.11b, More range, Low Transfer rate, More current draw
-- wifi.PHYMODE_G 802.11g, Medium range, Medium transfer rate, Medium current draw
-- wifi.PHYMODE_N 802.11n, Least range, Fast transfer rate, Least current draw 
wifi_signal_mode = wifi.PHYMODE_N
-- If the settings below are filled out then the module connects 
-- using a static ip address which is faster than DHCP and 
-- better for battery life. Blank "" will use DHCP.
-- My own tests show around 1-2 seconds with static ip
-- and 4+ seconds for DHCP
client_ip=""
client_netmask=""
client_gateway=""

--- INTERVAL ---
-- In milliseconds. Remember that the sensor reading, 
-- reboot and wifi reconnect takes a few seconds
time_between_sensor_readings = 60000

--################
--# END settings #
--################

-- Setup MQTT client and events
m = mqtt.Client(client_id, 120, username, password)
temperature = 0
humidity = 0

-- Connect to the wifi network
wifi.setmode(wifi.STATION) 
wifi.setphymode(wifi_signal_mode)
wifi.sta.config(wifi_SSID, wifi_password) 
wifi.sta.connect()
if client_ip ~= "" then
    wifi.sta.setip({ip=client_ip,netmask=client_netmask,gateway=client_gateway})
end

-- DHT22 sensor logic
function get_sensor_Data() 
    DHT= require("dht22_min")
    DHT.read(4)
    temperature = DHT.getTemperature()
    humidity = DHT.getHumidity()

    if humidity == nil then
        print("Error reading from DHT22")
    else
        print("Temperature: "..(temperature / 10).."."..(temperature % 10).." deg C")
        print("Humidity: "..(humidity / 10).."."..(humidity % 10).."%")
    end
    DHT = nil
    package.loaded["dht22_min"]=nil
end

function loop() 
	-- 0: STA_IDLE,
	-- 1: STA_CONNECTING,
	-- 2: STA_WRONGPWD,
	-- 3: STA_APNOTFOUND,
	-- 4: STA_FAIL,
	-- 5: STA_GOTIP.
    if wifi.sta.status() == 5 then
        -- Stop the loop
        tmr.stop(0)
        m:connect( mqtt_broker_ip , mqtt_broker_port, 0, function(conn)
            print("Connected to MQTT")
            print("  IP: ".. mqtt_broker_ip)
            print("  Port: ".. mqtt_broker_port)
            print("  Client ID: ".. mqtt_client_id)
            print("  Username: ".. mqtt_username)
            -- Get sensor data
            get_sensor_Data() 
            m:publish("ESP8266/temperature",(temperature / 10).."."..(temperature % 10), 0, 0, function(conn)
                m:publish("ESP8266/humidity",(humidity / 10).."."..(humidity % 10), 0, 0, function(conn)
                    print("Going to deep sleep for "..(time_between_sensor_readings/1000).." seconds")
                    node.dsleep(time_between_sensor_readings*1000)             
                end)          
            end)
        end )
    else
        print("Connecting...")
    end
end
        
tmr.alarm(0, 100, 1, function() loop() end)