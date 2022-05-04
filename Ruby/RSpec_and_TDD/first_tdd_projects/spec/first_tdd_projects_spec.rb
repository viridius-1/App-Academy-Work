require 'rspec'
require 'first_tdd_projects'

describe '#my_uniq' do 
    let(:array) { [1, 1, 2, 2, 3, 3] }
   
    it 'takes in an array' do 
        expect { my_uniq(array) }.to_not raise_error
    end 
       
    it 'returns array with unique elements in the order they appear in the array' do 
        expect(my_uniq(array)).to eq([1, 2, 3])
    end 
end 

describe 'Array' do 
    describe '#two_sum' do 
        it 'finds pairs of positions in array that sum to 0' do 
            expect([-1, 0, 2, -2, 1].two_sum). to eq([[0, 4], [2, 3]])
        end 

        it 'sorts pairs with the smaller index before the bigger index' do 
            expect([9, 9, -9].two_sum).to eq([[0, 2], [1, 2]])
            expect([5, -5, -5].two_sum).to eq([[0, 1], [0, 2]])
        end 

        it 'returns an empty array when there are no pairs of positions that sum to 0' do 
            expect([0, 5, 9].two_sum).to eq([])
        end 

        it 'handles an array with two zeros' do 
            expect([0, 5, 9, 0].two_sum).to eq([[0, 3]])
        end 
    end     
end 

describe '#my_transpose' do 
    it 'takes in a 2D array' do 
        expect{ my_transpose([
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]) }.to_not raise_error
    end 

    it 'transposes a 2D array of rows to the corresponding 2D array of columns' do 
          expect(my_transpose([
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ])).to eq([
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8]
        ])
    end 
end 

describe '#stock_picker' do 
    it 'returns the days to buy a stock and sell it in order to make the most profit in array format' do 
        expect(stock_picker([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])).to eq([0, 9])
        expect(stock_picker([5, 1, 9, 12, 15, 3, 8])).to eq([1, 4])
        expect(stock_picker([5, 9, 12, 15, 3, 8])).to eq([0, 3])
    end 

    it 'returns an empty array if there are no days where a profit can be made' do 
        expect(stock_picker([15, 14, 12, 5])).to eq([])
        expect(stock_picker([15, 15, 15])).to eq([])
    end 
end 

describe '#TowersOfHanoi' do 
    subject(:game) { TowersOfHanoi.new }

    it 'starts with all disks on rod 1' do 
        expect(game.tower1).to eq([8, 7, 6, 5, 4, 3, 2, 1])
    end 

    it 'moves a disk from one rod to another rod' do 
        game.move_disk(1, 2)
        expect(game.tower1).to eq([8, 7, 6, 5, 4, 3, 2])
        expect(game.tower2).to eq([1])
    end 

    it 'raises an error if a disk is placed on a smaller disk' do 
        game.move_disk(1, 2)
        expect{ game.move_disk(1, 2) }.to raise_error("A disk can't be put on a smaller disk.")
    end 

    it 'returns true when the game is won' do 
        game.tower1 = []
        game.tower2 = [8, 7, 6, 5, 4, 3, 2, 1]
        game.tower3 = []
        expect(game.won?).to be(true)
    end 
end 
