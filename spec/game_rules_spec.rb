# require "gameBoard"
# require "cell"
require "gameRules"


describe GameRules do 
	let(:gameBoard){GameBoard.new}

	context 'there are no cells' do 
		it 'should have no living cells in the next generation' do 
			 cell = Cell.new({x:1,y:1})
			 gameBoard.add(cell)
			 game = GameRules.new(gameBoard)
			 expect(gameBoard.living_cells.count).to eq 1
			 game.nextGeneration
			 expect(gameBoard.living_cells.count).to eq 0
		end

		it 'should have create living cells in the next generatio if surrounded by 4' do 
			 cell = Cell.new({x:1,y:1})
			 cell2 = Cell.new({x:1,y:3})
			 cell3= Cell.new({x:0,y:2})
			 cell4 = Cell.new({x:2,y:2})
			 gameBoard.add(cell)
			 gameBoard.add(cell2)
			 gameBoard.add(cell3)
			 gameBoard.add(cell4)
			 game = GameRules.new(gameBoard)
			 expect(gameBoard.living_cells.count).to eq 4
			 game.nextGeneration
			 expect(gameBoard.living_cells.count).to eq 5
		end

		it 'should have no living cells in the next generation if 4 cells' do 
			 cell = Cell.new({x:1,y:1})
			 cell2 = Cell.new({x:1,y:3})
			 cell3= Cell.new({x:0,y:2})
			 cell4 = Cell.new({x:2,y:2})
			 cell5 = Cell.new({x:1,y:2})
			 gameBoard.add(cell)
			 gameBoard.add(cell2)
			 gameBoard.add(cell3)
			 gameBoard.add(cell4)
			 gameBoard.add(cell5)
			 game = GameRules.new(gameBoard)
			 expect(gameBoard.living_cells.count).to eq 5
			 game.nextGeneration
			 expect(gameBoard.living_cells.count).to eq 4
		end

		it 'should have no cells removed or added' do 
			 cell = Cell.new({x:1,y:1})
			 cell2 = Cell.new({x:1,y:2})
			 cell3= Cell.new({x:2,y:1})
			 cell4 = Cell.new({x:2,y:2})
			 gameBoard.add(cell)
			 gameBoard.add(cell2)
			 gameBoard.add(cell3)
			 gameBoard.add(cell4)
			 game = GameRules.new(gameBoard)
			 expect(gameBoard.living_cells.count).to eq 4
			 game.nextGeneration
			 expect(gameBoard.living_cells.count).to eq 4
		end

		it 'should have fluctuate living cells in the next generatio if surrounded by 4' do 
			 cell = Cell.new({x:1,y:1})
			 cell2 = Cell.new({x:1,y:3})
			 cell3= Cell.new({x:0,y:2})
			 cell4 = Cell.new({x:2,y:2})
			 gameBoard.add(cell)
			 gameBoard.add(cell2)
			 gameBoard.add(cell3)
			 gameBoard.add(cell4)
			 game = GameRules.new(gameBoard)
			 expect(gameBoard.living_cells.count).to eq 4

			 game.nextGeneration
			 expect(gameBoard.living_cells.count).to eq 5
			 game.nextGeneration
			 expect(gameBoard.living_cells.count).to eq 4


		end

	end



end