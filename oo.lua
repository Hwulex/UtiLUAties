

A = {
	foo = 3,

	m = function( self )
		print( self.foo )
	end
}

function A.new()
	local o = {}
	setmetatable(o, { __index = A })

	o.b		= B
	o.c		= C
	return o
end

function A:x()
	self.b:m()
end

B = {
	bar = 2,

	m = function( self )
		print( a.c:m() )
	end
}

C = {
	nod = "b",

	m = function( self )
		print( self.nod )
	end
}


a = A.new();
a.m(a)
a:x()
