require 'nauseating_numbers'

describe "strange_sums" do 
    let(:array_1) { [2, -3, 3, 4, -2] }
    let(:array_2) { [42, 3, -1, -42] }
    let(:array_3) { [-5, 5] }
    let(:array_4) { [19, 6, -3, -20] }
    let(:array_5) { [9] }

    it "should accept an array as an argument" do 
        expect { strange_sums(array_1) }.to_not raise_error 
    end 

    it "should return the number of pairs that sum to 0" do 
        expect(strange_sums(array_1)).to eq(2)
        expect(strange_sums(array_2)).to eq(1)
        expect(strange_sums(array_3)).to eq(1)
        expect(strange_sums(array_4)).to eq(0)
        expect(strange_sums(array_5)).to eq(0)
    end 
end 


describe "pair_product" do 
    it "should accept an array and a product as arguments" do 
        expect { pair_product([4, 2, 5, 8], 16) }.to_not raise_error  
    end 

    it "should return true if a pair of elements in the array can produce the product" do 
        expect(pair_product([4, 2, 5, 8], 16)).to eq(true) 
        expect(pair_product([8, 1, 9, 3], 8)).to eq(true)
        expect(pair_product([3, 4], 12)).to eq(true)
        expect(pair_product([3, 4, 6, 2, 5], 12)).to eq(true)
    end 

    it "should return false if a pair of elements in the array can't produce the product" do 
        expect(pair_product([4, 2, 5, 7], 16)).to eq(false)
        expect(pair_product([8, 4, 9, 3], 8)).to eq(false)
        expect(pair_product([3], 12)).to eq(false) 
    end 
end 


describe "rampant_repeats" do 
    it "should accept a string and a hash as arguments" do 
        expect { rampant_repeats('taco', {'a'=>3, 'c'=>2}) }.to_not raise_error 
    end 

    it "returns a new string where characters are repeated by the number of times specified in the hash" do 
        expect(rampant_repeats('taco', {'a'=>3, 'c'=>2})).to eq('taaacco') 
        expect(rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3})).to eq('ffffeeveerisssh')
        expect(rampant_repeats('misispi', {'s'=>2, 'p'=>2})).to eq('mississppi')
        expect(rampant_repeats('faarm', {'e'=>3, 'a'=>2})).to eq('faaaarm')
    end 
end 


describe "perfect_square" do 
    it "should accept a number as an argument" do 
        expect { perfect_square(5) }.to_not raise_error 
    end 

    it "returns true if a number is a perfect square" do 
        expect(perfect_square(1)).to eq(true)
        expect(perfect_square(4)).to eq(true)
        expect(perfect_square(64)).to eq(true)
        expect(perfect_square(100)).to eq(true)
        expect(perfect_square(169)).to eq(true)
    end 

    it "returns false if a number is not a perfect square" do 
        expect(perfect_square(2)).to eq(false)
        expect(perfect_square(40)).to eq(false)
        expect(perfect_square(32)).to eq(false)
        expect(perfect_square(50)).to eq(false) 
    end 
end 


describe "anti_prime?" do 
    it "should accept a number as an argument" do 
        expect { anti_prime?(5) }.to_not raise_error 
    end 

    it "returns true if a number is a anti-prime" do 
        expect(anti_prime?(24)).to eq(true) 
        expect(anti_prime?(36)).to eq(true)
        expect(anti_prime?(48)).to eq(true)
        expect(anti_prime?(360)).to eq(true)
        expect(anti_prime?(1260)).to eq(true)
    end 

    it "returns false if a number isn't a anti-prime" do 
        expect(anti_prime?(27)).to eq(false) 
        expect(anti_prime?(5)).to eq(false)
        expect(anti_prime?(100)).to eq(false)
        expect(anti_prime?(136)).to eq(false)
        expect(anti_prime?(1024)).to eq(false)
    end 
end 


describe "matrix_addition" do 
    let(:matrix_a) { [[2,5], [4,7]] }
    let(:matrix_b) { [[9,1], [3,0]] }
    let(:matrix_c) { [[-1,0], [0,-1]] }
    let(:matrix_d) { [[2, -5], [7, 10], [0, 1]] }
    let(:matrix_e) { [[0 , 0], [12, 4], [6, 3]] }

    it "should accept 2 matrices as arguments" do 
        expect { matrix_addition(matrix_a, matrix_b) }.to_not raise_error 
    end 

    it "adds matrices together" do 
        expect(matrix_addition(matrix_a, matrix_b)). to eq( [[11, 6], [7, 7]] )
        expect(matrix_addition(matrix_a, matrix_c)).to eq( [[1, 5], [4, 6]] )
        expect(matrix_addition(matrix_b, matrix_c)).to eq( [[8, 1], [3, -1]] ) 
        expect(matrix_addition(matrix_d, matrix_e)).to eq( [[2, -5], [19, 14], [6, 4]] )

    end 
end 


describe "mutual_factors" do 
    it "should accept any number of arguments as numbers" do 
        expect { mutual_factors(50, 30) }.to_not raise_error 
        expect { mutual_factors(50, 30, 45, 105) }.to_not raise_error 
    end 

    it "should return an array of shared common divisors among the numbers" do 
        expect(mutual_factors(50, 30)).to eq([1, 2, 5, 10])
        expect(mutual_factors(50, 30, 45, 105)).to eq([1, 5])
        expect(mutual_factors(8, 4)).to eq([1, 2, 4])
        expect(mutual_factors(8, 4, 10)).to eq([1, 2])
        expect(mutual_factors(12, 24)).to eq([1, 2, 3, 4, 6, 12])
        expect(mutual_factors(12, 24, 64)).to eq([1, 2, 4])
        expect(mutual_factors(22, 44)).to eq([1, 2, 11, 22])
        expect(mutual_factors(22, 44, 11)).to eq([1, 11])
        expect(mutual_factors(7)).to eq([1, 7])
        expect(mutual_factors(7, 9)).to eq([1]) 
    end 
end 


describe "tribonacci_number" do 
    it "should accept a number as an argument" do 
        expect { tribonacci_number(5) }.to_not raise_error 
    end 

    it "should return the n-th number of the tribonacci sequence" do 
        expect(tribonacci_number(1)).to eq(1)
        expect(tribonacci_number(2)).to eq(1)
        expect(tribonacci_number(3)).to eq(2)
        expect(tribonacci_number(4)).to eq(4)
        expect(tribonacci_number(5)).to eq(7)
        expect(tribonacci_number(6)).to eq(13)
        expect(tribonacci_number(7)).to eq(24)
        expect(tribonacci_number(11)).to eq(274)
    end 
end 






# require 'exercise'

# describe "zip" do
#     let(:array_1) { ['a', 'b', 'c'] }
#     let(:array_2) { [1, 2, 3] }
#     let(:array_3) { ['w', 'x', 'y'] }

#     it "should accept any number of arrays of the same length as arguments" do
#         expect { zip(array_1) }.to_not raise_error
#         expect { zip(array_1, array_2) }.to_not raise_error
#         expect { zip(array_1, array_2, array_3) }.to_not raise_error
#     end

#     it "should return a 2D array where each subarray contains the elements at the same index from each argument" do
#         expect(zip(array_1, array_2)).to eq([
#             ["a", 1],
#             ["b", 2],
#             ["c", 3]
#         ])

#         expect(zip(array_2, array_1)).to eq([
#             [1, "a"],
#             [2, "b"],
#             [3, "c"]
#         ])

#         expect(zip(array_1, array_2, array_3)).to eq([
#             ["a", 1, "w"],
#             ["b", 2, "x"],
#             ["c", 3, "y"]
#         ])
#     end
# end

# describe "prizz_proc" do
#     let(:div_3) { Proc.new { |n| n % 3 == 0 } }
#     let(:div_5) { Proc.new { |n| n % 5 == 0 } }
#     let(:ends_ly) { Proc.new { |s| s.end_with?('ly') } }
#     let(:has_i) { Proc.new { |s| s.include?('i') } }

#     it "should accept an array and two procs as arguments" do
#         expect { prizz_proc([10, 9, 3, 45, 12, 15], div_3, div_5) }.to_not raise_error
#     end

#     it "should return a new array containing the elements that return true for exactly one of the procs" do
#         expect(
#             prizz_proc(
#                 [10, 9, 3, 45, 12, 15, 7],
#                 div_3,
#                 div_5
#             )
#         ).to match_array([10, 9, 3, 12])

#         expect(
#             prizz_proc(
#                 ['honestly', 'sully', 'sickly', 'trick', 'doggo', 'quickly'],
#                 ends_ly,
#                 has_i
#             )
#         ).to match_array(['honestly', 'sully', 'trick'])
#     end

#     it "should return elements in the same order they appear in the input array" do
#         expect(
#             prizz_proc(
#                 [10, 9, 3, 45, 12, 15, 7],
#                 div_3,
#                 div_5
#             )
#         ).to eq([10, 9, 3, 12])

#         expect(
#             prizz_proc(
#                 ['honestly', 'sully', 'sickly', 'trick', 'doggo', 'quickly'],
#                 ends_ly,
#                 has_i
#             )
#         ).to eq(['honestly', 'sully', 'trick'])
#     end
# end

# describe "zany_zip" do
#     let(:array_1) { ['a', 'b', 'c'] }
#     let(:array_2) { [1, 2, 3] }
#     let(:array_3) { [11, 13, 15, 17] }
#     let(:array_4) { ['v', 'w', 'x', 'y', 'z'] }

#     it "should accept any number of arrays as arguments" do
#         expect { zany_zip(array_1) }.to_not raise_error
#         expect { zany_zip(array_1, array_2) }.to_not raise_error
#         expect { zany_zip(array_1, array_2, array_3) }.to_not raise_error
#     end

#     it "should return a 2D array where each subarray contains the elements at the same index from each argument" do
#         expect(zany_zip(array_1, array_2)).to eq([
#             ["a", 1],
#             ["b", 2],
#             ["c", 3]
#         ])

#         expect(zany_zip(array_2, array_1)).to eq([
#             [1, "a"],
#             [2, "b"],
#             [3, "c"]
#         ])
#     end

#     it "should use nil to substitute elements for the array that are too short" do
#         expect(zany_zip(array_3, array_2, array_1)).to eq([
#             [11, 1, "a"],
#             [13, 2, "b"],
#             [15, 3, "c"],
#             [17, nil, nil]
#         ])

#         expect(zany_zip(array_1, array_2, array_3, array_4)).to eq([
#             ["a", 1,    11,     "v"],
#             ["b", 2,    13,     "w"],
#             ["c", 3,    15,     "x"],
#             [nil, nil,  17,     "y"],
#             [nil, nil,  nil,    "z"]
#         ])
#     end
# end

# describe "maximum" do
#     it "should accept an array and a block as args" do
#         expect { maximum([2, 4, -5, 1]) { |n| n * n } }.to_not raise_error
#         expect { maximum(['potato', 'swimming', 'cat']) { |w| w.length } }.to_not raise_error
#     end

#     it "should return the element that has the largest result when passed into the block" do
#         expect(maximum([2, 4, -5, 1]) { |n| n * n }).to eq(-5)
#         expect(maximum(['potato', 'swimming', 'cat']) { |w| w.length }).to eq('swimming')
#     end

#     context "when there is a tie" do
#         it "should return the element that appears later in the array" do
#         expect(maximum(['boot', 'cat', 'drop']) { |w| w.length }).to eq('drop')
#         end
#     end

#     context "when the array is empty" do
#         it "should return nil" do
#             expect(maximum([]) { |w| w.length}).to eq(nil)
#         end
#     end
# end

# describe "my_group_by" do
#     let(:array_1) { ['mouse', 'dog', 'goat', 'bird', 'cat'] }
#     let(:array_2) { [1, 2, 9, 30, 11, 38] }

#     it "should accept an array and a block as args" do
#         expect{ my_group_by(array_1) { |s| s.length } }.to_not raise_error
#     end

#     it "should not use the built-in Array#group_by" do
#         expect(array_1).to_not receive(:group_by)
#         my_group_by(array_1) { |s| s.length }
#     end

#     it "should return a hash where keys are the results when the elements are given to the block" do
#         answer_1 = {5=>["mouse"], 3=>["dog", "cat"], 4=>["goat", "bird"]}
#         expect(my_group_by(array_1) { |s| s.length }.keys).to match_array(answer_1.keys)

#         answer_2 = {true=>["mouse", "dog", "goat"], false=>["bird", "cat"]}
#         expect(my_group_by(array_1) { |s| s.include?('o') }.keys).to match_array(answer_2.keys)
#     end

#     it "should return a hash where each value is an array containing the elements that result in the corresponding key when given to the block" do
#         answer_1 = {5=>["mouse"], 3=>["dog", "cat"], 4=>["goat", "bird"]}
#         expect(my_group_by(array_1) { |s| s.length }).to match_array(answer_1)

#         answer_2 = {true=>["mouse", "dog", "goat"], false=>["bird", "cat"]}
#         expect(my_group_by(array_1) { |s| s.include?('o') }).to match_array(answer_2)

#         answer_3 = {1=>[1], 2=>[2, 11, 38], 0=>[9, 30]}
#         expect(my_group_by(array_2) { |n| n % 3 }).to eq(answer_3)
#     end
# end

# describe "max_tie_breaker" do
#     let(:array_1) { ['potato', 'swimming', 'cat'] }
#     let(:array_2) { ['cat', 'bootcamp', 'swimming', 'ooooo'] }
#     let(:array_3) { ['photo','bottle', 'bother'] }
#     let(:length) { Proc.new { |s| s.length } }
#     let(:o_count) { Proc.new { |s| s.count('o') } }

#     it "should accept an array, a proc, and a block as args" do
#         expect { max_tie_breaker(array_1, length, &o_count) }.to_not raise_error
#     end

#     it "should return the element that has the largest result when passed into the block" do
#         expect(max_tie_breaker(array_1, o_count, &length)).to eq('swimming')
#         expect(max_tie_breaker(array_2, length, &o_count)).to eq('ooooo')

#     end

#     context "when there is a tie" do
#         it "should use the proc to break the tie" do
#             expect(max_tie_breaker(array_2, o_count, &length)).to eq('bootcamp')
#         end

#         context "when there is still a tie after using the proc" do
#             it "should return the element that comes first in the array" do
#                 expect(max_tie_breaker(array_3, o_count, &length)).to eq('bottle')
#             end
#         end
#     end

#     context "when the array is empty" do
#         it "should return nil" do
#             expect(max_tie_breaker([], o_count, &length)).to eq(nil)
#         end
#     end
# end

# describe "silly_syllables" do
#     it "should accept a sentence as an argument" do
#         expect { silly_syllables('properly and precisely written code') }.to_not raise_error
#     end

#     it "should return a new sentence where all letters before the first vowel and after the last vowel are removed" do
#         expect(silly_syllables('properly precisely written code')).to eq('ope ecise itte ode')
#         expect(silly_syllables('trashcans collect garbage')).to eq('ashca olle arbage')
#     end

#     it "should not remove letters for words that contain less than two vowels" do
#         expect(silly_syllables('properly and precisely written code')).to eq('ope and ecise itte ode')
#         expect(silly_syllables('the trashcans collect all my garbage')).to eq('the ashca olle all my arbage')
#     end
# end
