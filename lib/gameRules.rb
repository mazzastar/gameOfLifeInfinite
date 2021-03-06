require "gameBoard"
require "cell"

class GameRules	
	def initialize(board)
		@board = board
	end

	def nextGeneration
		living_cells, living_coords = living_cells_info(@board)

		kill_list(living_cells, living_coords).each do |cell|
			@board.remove(cell)
		end

		create_list(living_cells, living_coords).each do |cell|
			@board.add(cell)
		end
	end

	def living_cells_info(board) 
		living_cells = board.living_cells
		living_coords = living_cells.map{|cell| cell.coords}
		[living_cells, living_coords]	
	end

	def low_population?(count)
		count <2
	end

	def overcrowded?(count)
		count >3
	end

	def ressurect?(count)
		count>=4
	end

	def kill_list(living_cells, living_coords)
		kill_list = living_cells.select do |cell|
			kill_rule(cell.neighbours_of, living_coords)
		end
	end

	def kill_rule(cell_coords, living_coords)
		match_count = overlap_count(cell_coords,living_coords)
		overcrowded?(match_count)||low_population?(match_count)
	end

	def create_list(living_cells, living_coords)
		dead_cells_coords = dead_cells(living_cells, living_coords)
		cells_to_create(dead_cells_coords, living_coords)
	end

	def dead_cells(living_cells, living_coords)
		dead_cells = living_cells.map{|living_cell| living_cell.neighbours_of}
		dead_cells.flatten.uniq - living_coords.flatten
	end

	def cells_to_create(coords_to_check, living_coords)
		new_cells = coords_to_check.map{|coord| Cell.new(coord)}
		new_cells.select{|cell| create_rule(cell.neighbours_of, living_coords)}
	end

	def create_rule(dead_coords, living_coords)
		match_count = overlap_count(dead_coords,living_coords)
		ressurect?(match_count)
	end

	def overlap_count(coords1, coords2)
		(coords1&coords2).count
	end
end
