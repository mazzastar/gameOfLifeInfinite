require "gameBoard"
require "cell"

class GameRules	
	def initialize(board)
		@board = board
	end

	def nextGeneration
		@living_cells, living_coords = living_cells_info(@board)

		kill_list(@living_cells, living_coords).each do |cell|
			@board.remove(cell)
		end

		create_list(@living_cells, living_coords).each do |cell|
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
		neigbouring_live_cells_coords=(cell_coords&living_coords)
		match_count = neigbouring_live_cells_coords.count
		overcrowded?(match_count)||low_population?(match_count)
	end

	def create_list(living_cells, living_coords)
		potential_cells_coords = potential_cells(living_cells, living_coords)
		cells_to_create(potential_cells_coords, living_coords)
	end

	def potential_cells(living_cells, living_coords)
		potential_cells = living_cells.map{|living_cell|living_cell.neighbours_of}
		potential_cells.flatten.uniq - living_coords.flatten
	end

	def cells_to_create(cells_coords_to_check, living_cells_coords)
		cells_to_create = []
		cells_coords_to_check.each do |cell_coord|
			new_cell = Cell.new(cell_coord)
			cells_to_create << new_cell if create_rule(new_cell.neighbours_of, living_cells_coords)
		end
		cells_to_create
	end

	def create_rule(potential_cell_coords, living_cells_coords)
		living_cells_overlap = potential_cell_coords&living_cells_coords
		match_count = (living_cells_overlap).count
		ressurect?(match_count)
	end

end
