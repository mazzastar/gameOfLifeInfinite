require "gameBoard"
require "cell"

class GameRules

	@living_cells
	 @cells_to_live
	 @cells_to_kill
	 @cells_to_add

	def initialize(board)
		@board=board
	end

	def nextGeneration
		kill_list
		create_list

		@cells_to_kill.each do |cell|
			@board.remove(cell)
		end
		
		@cells_to_add.each do |cell|
			@board.add(cell)
		end
	end

	def kill_list
		@cells_to_kill=[]
		@living_cells = @board.living_cells
		living_coords = @living_cells.map{|cell| cell.coords}
		
		@cells_to_kill= @living_cells.select do |cell|
			match_count = (cell.neighbours_of&living_coords).count
			(match_count <2)||(match_count >3)
		end
	end

	def create_list
		@cells_to_add = []
		cells_to_check = []

		@living_cells = @board.living_cells
		living_coords = @living_cells.map{|cell| cell.coords}

		@living_cells.each do |living_cell| 
			cells_to_check << living_cell.neighbours_of
		end
		
		cells_to_check=cells_to_check.flatten.uniq-living_coords.flatten

		cells_to_check.each do |cell_coord|
			new_cell = Cell.new(cell_coord)
			match_count = (new_cell.neighbours_of&living_coords).count 
			@cells_to_add<<new_cell if match_count>=4
		end

	end

end
