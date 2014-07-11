require "gameBoard"
require "cell"


describe GameBoard do 
	let(:gameBoard){GameBoard.new}
	it 'contains nothing initally' do 
		expect(gameBoard.living_cells.count).to eq 0
	end

	it 'can add cells' do 
		cell = Cell.new({x:1,y:2})
		cell2 = Cell.new({x:1,y:3})
		gameBoard.add(cell)
		gameBoard.add(cell2)
		expect(gameBoard.living_cells.include?(cell2)).to be true
	end

	it 'can remove cells' do 
		cell = Cell.new({x:1, y:2})
		cell2 = Cell.new({x:1, y:3})
		gameBoard.add(cell)
		gameBoard.add(cell2)
		gameBoard.remove(cell)
		expect(gameBoard.living_cells.include?(cell)).to be false
	end

end