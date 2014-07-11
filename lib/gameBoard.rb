class GameBoard

	attr_reader :living_cells

	def initialize
		@living_cells = []
	end

	def add(entity)
		@living_cells << entity if @living_cells
	end

	def remove(entity)
		@living_cells.delete(entity)
	end

	def match(entity)
		@living_cells.includes?(entity)
	end
end