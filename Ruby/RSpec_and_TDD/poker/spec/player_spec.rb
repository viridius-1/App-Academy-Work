require 'rspec'
require 'player'

describe Player do
    let(:deck) { Deck.new }
    let(:card) { double('card') }
    let(:hand) { double('hand') }

    let(:player1) { double('player1') }
    let(:player2) { double('player2') }
    let(:player3) { double('player3') }
    let(:player4) { double('player4') }

    subject(:player) { Player.new('Jake', deck) }  
    before(:each) do 
        player.deal_cards 

        allow(player1).to receive(:name).and_return('Jake')
        allow(player2).to receive(:name).and_return('Ann')
        allow(player3).to receive(:name).and_return('Mike')
        allow(player4).to receive(:name).and_return('Mary') 
    end 

    describe '#receive_chips' do 
        it 'increases the chip amount' do 
            player.chips = 10 
            player.chips += 1 
            expect(player.chips).to eq(11)
        end 
    end 

    context 'when game starts' do 
        it 'has chips' do 
            expect(player.chips).to eq(10)
        end 

        it "returns the player's name" do 
            expect(player.name).to eq('Jake')
        end 

        it 'can reference the deck' do 
            expect(player.deck).to eq(deck)
        end 

        it 'can reference the pot' do 
            expect(player.pot).to eq(nil)
        end 

        it "can reference the round's current bet" do 
            expect(player.round_current_bet).to eq(nil)
        end 

        it "has a player status that's alive" do 
            expect(player.alive).to be(true)
        end 
    end 

    context 'when dealing cards' do 
        describe '#deal_cards' do 
            it 'has a hand' do 
                expect(player.hand).to_not eq(nil)
            end 

            it 'has 5 cards' do 
                expect(player.hand.hand.length).to eq(5)
            end 
        end 
    end 

    context 'when a player makes the first turn' do 
        describe '#make_first_turn' do 
            before(:each) do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                allow(player).to receive(:get_first_player_choice).and_return('b')
                allow(player).to receive(:get_amount).and_return(1)
                player.make_first_turn(alive_players, eliminated_players)
            end 

            it 'sets already_bet to true' do 
                expect(player.already_bet).to be(true)
            end 

            it 'sets alive players' do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                allow(player).to receive(:alive_players).and_return(alive_players)
                player.make_first_turn(alive_players, eliminated_players)
                expect(player.alive_players).to eq(alive_players)
            end  

            it "returns the player's bet when the player wants to bet" do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                expect(player.make_first_turn(alive_players, eliminated_players)).to eq(1)
            end 

            it 'folds a player when the player wants to fold' do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                expect(player).to receive(:fold_player)
                allow(player).to receive(:get_first_player_choice).and_return('f')
                expect { player.make_first_turn(alive_players, eliminated_players) }.to_not raise_error
            end 
        end 
    end 

    context 'when a player makes the next turn in a round' do 
        describe '#make_next_turn' do 
            before(:each) do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                folded_players = []
                player_with_highest_bet = player 

                allow(player1).to receive(:fold).and_return(false)
                allow(player2).to receive(:fold).and_return(false)
                allow(player3).to receive(:fold).and_return(false)
                allow(player4).to receive(:fold).and_return(false)

                allow(player1).to receive(:chips).and_return(10)
                allow(player2).to receive(:chips).and_return(10)
                allow(player3).to receive(:chips).and_return(10)
                allow(player4).to receive(:chips).and_return(10)

                player.already_bet = true  
                player.round_current_bet = 2 
                player.bet = 1 
                player.chips = 9 
                allow(player).to receive(:gets)
                allow(player).to receive(:next_turn_decision).and_return('s')
                player.make_next_turn(alive_players, eliminated_players, folded_players, player_with_highest_bet)
            end 

            it 'sets alive players' do 
                alive_players = [player1, player2, player3, player4] 
                expect(player.alive_players).to eq(alive_players)
            end  

            it 'sets folded players' do 
                expect(player.folded_players).to eq([])
            end 

            it 'sets the player with the highest bet' do 
                expect(player.player_with_highest_bet).to eq(player)
            end 

            it "resets a player's bet data if a player hasn't already bet in a round" do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                folded_players = []
                player_with_highest_bet = player 
                player.already_bet = false 
                expect(player).to receive(:reset_bet_data)
                player.make_next_turn(alive_players, eliminated_players, folded_players, player_with_highest_bet)
            end 

            it 'sets already_bet to true' do 
                expect(player.already_bet).to be(true)
            end 

            it 'knows when a player can see a bet' do 
                expect(player.able_to_call).to be(true)
            end 

            it 'knows when a player can raise a bet' do 
                expect(player.able_to_raise).to be(true)
            end 

            it 'knows when a player must fold' do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                folded_players = []
                player_with_highest_bet = player 
                allow(player).to receive(:must_fold?).and_return(true)
                expect(player.make_next_turn(alive_players, eliminated_players, folded_players, player_with_highest_bet)).to eq('f')
            end 

            it "returns a player's decision if a player doesn't have to fold" do 
                alive_players = [player1, player2, player3, player4] 
                eliminated_players = []
                folded_players = []
                player_with_highest_bet = player 
                expect(player.make_next_turn(alive_players, eliminated_players, folded_players, player_with_highest_bet)).to eq('s')
            end 
        end 
    end 

    context 'when a player is deciding to see, raise, or fold' do 
        describe '#next_turn_decision' do 
            before(:each) do 
                allow(player1).to receive(:fold).and_return(false)
                allow(player2).to receive(:fold).and_return(false)
                allow(player3).to receive(:fold).and_return(false)
                allow(player4).to receive(:fold).and_return(false)

                allow(player1).to receive(:chips).and_return(9)
                allow(player2).to receive(:chips).and_return(9)
                allow(player3).to receive(:chips).and_return(9)
                allow(player4).to receive(:chips).and_return(9)

                alive_players = [player1, player2, player3, player4] 
                player.alive_players = alive_players

                player.round_current_bet = 2 
                player.bet = 1  
                player.chips = 9  
                allow(player).to receive(:get_next_player_choice).and_return('c')
            end

            it "increases the player's bet amount by the call amount when the player calls" do 
                player.next_turn_decision
                expect(player.bet).to eq(2)
            end 

            it "decreases the player's chip amount by the call amount when the player calls" do 
                player.next_turn_decision
                expect(player.chips).to eq(8)
            end 
             
            it "returns the call amount in an array when player calls" do 
                expect(player.next_turn_decision).to eq(['c', 1])
            end 

            it "increases the player's bet amount by the raise amount when the player raises" do 
                allow(player).to receive(:get_next_player_choice).and_return('r')
                allow(player).to receive(:get_amount).and_return(2)
                player.next_turn_decision
                expect(player.bet).to eq(3)
            end 

            it "decreases the player's chip amount by the raise amount when the player raises" do 
                allow(player).to receive(:get_next_player_choice).and_return('r')
                allow(player).to receive(:get_amount).and_return(2)
                player.next_turn_decision
                expect(player.chips).to eq(7)
            end 

            it "returns the bet amount in an array when player raises" do 
                allow(player).to receive(:get_next_player_choice).and_return('r')
                allow(player).to receive(:get_amount).and_return(2)
                expect(player.next_turn_decision).to eq(['r', 3, 2])
            end 

            it "folds a player when the player wants to fold" do 
                allow(player).to receive(:get_next_player_choice).and_return('f')
                expect(player.next_turn_decision).to eq(['f', 0])
            end 
        end 
    end 

    context 'when players are betting' do 
        describe '#illegal_characters?' do 
            it 'returns true when a bet has illegal characters' do 
                expect(player.illegal_characters?('5t')).to be(true)
            end 

            it 'returns false when a bet has no illegal characters' do 
            expect(player.illegal_characters?('5')).to be(false)
            end 
        end 

        describe '#legal_amount?' do 
            before(:each) do 
                alive_players = [player1, player2, player3, player4] 
                player.alive_players = alive_players

                allow(player1).to receive(:fold).and_return(false)
                allow(player2).to receive(:fold).and_return(false)
                allow(player3).to receive(:fold).and_return(false)
                allow(player4).to receive(:fold).and_return(false)

                allow(player1).to receive(:chips).and_return(9)
                allow(player2).to receive(:chips).and_return(9)
                allow(player3).to receive(:chips).and_return(9)
                allow(player4).to receive(:chips).and_return(9)

                allow(player).to receive(:invalid_amount) 
                allow(player).to receive(:gets)
            end 

            it 'returns true for a legal bet entry' do 
                expect(player.legal_amount?('5')).to be(true)
            end 

            it 'returns false for a bet that entry contains letters' do 
                expect(player.legal_amount?('5t')).to be(false)
            end 
        end 

        describe '#player_must_fold?' do 
            it 'returns true when a player must fold' do 
                player.able_to_call = false 
                player.able_to_raise = false 
                expect(player.must_fold?).to be(true)
            end 
        end 
        
        it 'can fold' do 
            player.fold = true 
            expect(player.fold).to be(true)
        end 
    end 
    
    context 'when exchanging cards' do  
        describe '#valid_user_exchange_choice?' do 

            it 'returns true for a valid entry when the hand_copy length is 5' do 
                player.hand_copy = ['9♠', 'Q♣', 'J♠', '5♠', '3♡']   
                expect(player.valid_user_exchange_choice?('v')).to be(true)
            end 

            it 'returns false for a invalid entry when the hand_copy length is 5' do 
                player.hand_copy = ['9♠', 'Q♣', 'J♠', '5♠', '3♡']   
                expect(player.valid_user_exchange_choice?('j')).to be(false)
            end 

            it 'returns true when a player wants to hold their cards' do 
                player.hand_copy = ['9♠', 'Q♣', 'J♠', '5♠', '3♡']   
                expect(player.valid_user_exchange_choice?('h')).to be(true)
            end 

            it 'returns true for a valid entry when the hand_copy length is 3 or 4' do 
                player.hand_copy = ['Q♣', 'J♠', '5♠', '3♡']   
                expect(player.valid_user_exchange_choice?('y')).to be(true)
            end 

            it 'returns false for a invalid entry when the hand_copy length is 3 or 4' do 
                player.hand_copy = ['Q♣', 'J♠', '5♠', '3♡']   
                expect(player.valid_user_exchange_choice?('z')).to be(false)
            end 

            it 'lets a player exchange cards when when the hand_copy length is 2, 3, or 4' do 
                player.hand_copy = ['Q♣', 'J♠', '5♠', '3♡']   
                expect(player.valid_user_exchange_choice?('e')).to be(true)
            end 

            it 'lets a player reset cards when when the hand_copy length is 2, 3, or 4' do 
                player.hand_copy = ['Q♣', 'J♠', '5♠', '3♡']   
                expect(player.valid_user_exchange_choice?('r')).to be(true)
            end 
        end 

        describe '#delete_cards_to_exchange' do 
            it 'deletes cards from a hand' do 
                player.hand.hand = ['9♠', 'Q♣', 'J♠', '5♠', '3♡']   
                player.cards_to_exchange = ['J♠', '5♠', '3♡']
                player.delete_cards_to_exchange
                expect(player.hand.hand.length).to eq(2)
            end 
        end 

        describe '#deal_new_cards' do 
            it "deals a player new cards" do 
                player.hand.hand = ['9♠', 'Q♣']  
                player.cards_to_exchange = ['J♠', '5♠', '3♡']
                allow(deck).to receive(:deal).with(3).and_return(['8♠', '4♡', '10♣'])
                player.deal_new_cards
                expect(player.hand.hand.length).to eq(5) 
            end 
        end 

        describe '#update_cards_to_exchange' do 
            it "marks a card to be exchanged" do 
                player.hand_copy = ['9♠', 'Q♣', 'J♠', '5♠', '3♡']   
                player.cards_to_exchange = []
                player.update_cards_to_exchange('v')
                expect(player.cards_to_exchange).to eq(['9♠'])
            end 
        end 
    end 
end 
