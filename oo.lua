

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
	return o
end

function A:x()
	self.b:m()
end

B = {
	bar = 2,

	m = function( self )
		print( a:m() )
	end
}

C = {
	nod = 3,

	m = function( self )
		print( self.nod )
	end
}


a = A.new();
a.m(a)
a:x()
