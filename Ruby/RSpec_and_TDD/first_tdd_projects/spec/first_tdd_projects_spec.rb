require 'rspec'
require 'first_tdd_projects'

describe '#my_uniq' do 
    #look for AA solutuon on taking in a parameter...how do they do that?
    it 'takes in an array' do 
        expect { my_uniq([1, 2, 3]) }.to_not raise_error
    end 
       
    it 'returns array with unique elements in the order they appear in the array' do 
        expect(my_uniq([1, 1, 2, 2, 3, 3])).to eq([1, 2, 3])
    end 
end 

describe 'Array' do 
    describe '#two_sum' do 
        it 'finds pairs of positions in array that sum to 0' do 
            expect([-1, 0, 2, -2, 1].two_sum). to eq([[0, 4], [2, 3]])
        end 

        it 'sorts pairs with the smaller index before the bigger index' do 
            expect([9, 9, -9].two_sum). to eq([[0, 2], [1, 2]])
            expect([5, -5, -5].two_sum). to eq([[0, 1], [0, 2]])
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