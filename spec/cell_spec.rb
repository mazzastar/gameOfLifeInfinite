require "cell"

describe Cell do 
	let(:coords){{x:0, y:0}}
	
	specify 'A Cell can be intialized' do 
		cell = Cell.new(coords)
		expect(cell.coords).to eq({x:0, y:0})
	end

	it 'can return expected neighbours' do 
		cell = Cell.new(coords)
		expect(cell.neighbours_of.count).to eq 8
		expect(cell.neighbours_of.include?({x:-1,y:-1})).to be true
		expect(cell.neighbours_of).to eq([{x:-1,y:-1},{x:-1,y:0},{x:-1,y:1},{x:0,y:-1},{x:0,y:1},{x:1,y:-1},{x:1,y:0},{x:1,y:1}])	
	end

end