class Cell

	attr_reader :coords

	def initialize(coords)
		x = coords[:x]
		y = coords[:y]
		@coords = {x:x,y:y}
	end

	def neighbours_of
		ignore_cell = [@coords[:x], @coords[:y]]
		neighbours=cartesian_square(@coords)
		neighbours=(neighbours.reject{|x| x==ignore_cell})
		neighbours.map{|el| {x:el[0], y:el[1]}}
	end

	def cartesian_square(coords)
		x_range = ((coords[:x]-1)..(coords[:x]+1)).to_a
		y_range = ((coords[:y]-1)..(coords[:y]+1)).to_a
		neighbours=(x_range).product(y_range)
	end
end