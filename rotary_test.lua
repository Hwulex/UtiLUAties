function rotaryturn3 (level)
  if level~=gpio.read(4) then
    print("Turning right")
  end
end

function rotaryturn4 (level)
  if level~=gpio.read(3) then
    print("Turning left")
  end
end

function rotarybutton (level)
  if level==0 then
    print("Button pushed")
  else
    print("Button released")
  end
end

gpio.mode(3,gpio.INPUT)
gpio.mode(4,gpio.INPUT)
gpio.mode(5,gpio.INPUT)

gpio.trig( 3, "both", rotaryturn3 )
gpio.trig( 4, "both", rotaryturn4 )
gpio.trig( 5, "both", rotarybutton )
