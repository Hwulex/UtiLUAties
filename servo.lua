servo = {}
servo.pin = 5 --this is GPIO2
servo.value = 1500
servo.id = "servo"

gpio.mode(servo.pin,gpio.OUTPUT)
gpio.write(servo.pin,gpio.LOW)

tmr.alarm(0,2000,1,function() -- 50Hz
    if servo.value then -- generate pulse
        gpio.write(servo.pin, gpio.HIGH)
        tmr.delay(servo.value)
        gpio.write(servo.pin, gpio.LOW)
    end
end)
