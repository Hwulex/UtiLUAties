servo = {}
servo.pin = 2 --this is GPIO1
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



-- Spectrum
-- 400 = 180 deg
-- 1400 = 90 deg
-- 2400 = 180 deg
