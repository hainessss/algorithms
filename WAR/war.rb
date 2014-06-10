require 'pry-debugger'


# This class is complete. You do not need to alter this
class Card
  attr_reader :rank, :value, :suit
  # Rank is the rank of the card, 2-10, J, Q, K, A
  # Value is the numeric value of the card, so J = 11, A = 14
  # Suit is the suit of the card, Spades, Diamonds, Clubs or Hearts
  def initialize(rank, value, suit)
    @rank = rank
    @value = value
    @suit = suit
  end
end

# TODO: You will need to complete the methods in this class
class Deck
  attr_accessor :deck, :store
  attr_reader :index
  def initialize
    @deck = [] # Determine the best way to hold the cards
    @store = []
    @index = 0
  end

  # Given a card, insert it on the bottom your deck
  def add_card(card)
    @store << card
  end

  # Mix around the order of the cards in your deck
  def shuffle # You can't use .shuffle!
    52.times do |i|
      j = rand(51)
      @deck[i], @deck[j] = @deck[j], @deck[i]
    end
  end

  # Remove the top card from your deck and return it
  def deal_card
    dealt_card = deck[@index]
    deck[@index] = nil
    @index += 1

    # if deck[@index] == nil
    #   @deck = @store
    #   @store = []
    #   @index = 0
    # end

    dealt_card
    # binding.pry
  end

  def check_deck
    if deck[@index] == nil
      @deck = @store
      @store = []
      @index = 0
    end
  end

  # Reset this deck with 52 cards
  def create_52_card_deck
    temp_value = 11
    ['hearts','spades','diamonds','clubs'].each do |suit|
      (2..10).each do |value|
        @deck <<  Card.new(value, value, suit)
      end
      ['J','Q','K','A'].each do |face|
        @deck <<  Card.new(face, temp_value, suit)
        temp_value += 1
      end
    end
  end
end

# You may or may not need to alter this class
class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = Deck.new
  end
end


class War
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @deck = Deck.new
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)

    @deck.create_52_card_deck
    @deck.shuffle

    26.times do
      @player1.hand.deck << @deck.deck.pop
      @player2.hand.deck << @deck.deck.pop
    end
  end

  # You will need to play the entire game in this method using the WarAPI
  def play_game
      until @player1.hand.deck == [] || @player2.hand.deck == []

        deck_p1 = @player1.hand
        deck_p2 = @player2.hand

        # deck_p1.check_deck
        # deck_p2.check_deck

        draw_p1 = deck_p1.deal_card
        draw_p2 = deck_p2.deal_card
        @turn_count = 0

        puts "#{@player1.name} played a #{draw_p1.rank}"
        puts "#{@player2.name} played a #{draw_p2.rank}"
        # binding.pry
        result = WarAPI.play_turn(@player1, draw_p1, @player2, draw_p2)
        result[player1].each { |v| deck_p1.add_card(v) ; puts "player 1 won a #{v.rank} for his hand" }
        result[player2].each { |v| deck_p2.add_card(v) ; puts "player 1 won a #{v.rank} to his hand" }

        deck_p1.check_deck
        deck_p2.check_deck

        # binding.pry
        @turn_count += 1
      end
      get_winner
  end

  # def draw
  #   deck_p1 = @player1.hand
  #   deck_p2 = @player2.hand

  #   draw_battle = []
  #   # draw_battle << 3.times { @player1.hand.deal_card }
  #   # draw_battle << 3.times { @player2.hand.deal_card }

  #   draw_p1 = deck_p1.deal_card
  #   draw_p2 = deck_p2.deal_card

  #   result = WarAPI.play_turn(@player1, draw_p1, @player2, draw_p2)
  #   result[player1].each { |v| deck_p1.add_card(v) ; puts "player 1 won a #{v} for his hand" }
  #   result[player2].each { |v| deck_p2.add_card(v) ; puts "player 1 won a #{v} to his hand" }

  #   if result[player1] = []
  #     draw_battle.each { |v| deck_p1.add_card(v) ; puts "player 1 won a #{v} for his hand" }
  #   else
  #     draw_battle.each { |v| deck_p2.add_card(v) ; puts "player 1 won a #{v} to his hand" }
  #   end
  # end

  def get_winner
    if @player1.hand.deck.length == []
      puts "#{@player2.name} has one the game in #{@turn_count} turns"
      @player2
    else
      puts "#{@player1.name} has one the game in #{@turn_count} turns"
      @player1
    end
  end

end

class WarAPI
  # This method will take a card from each player and
  # return a hash with the cards that each player should receive
  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {player1 => [card1, card2], player2 => []}
    elsif card2.value > card1.value
      {player1 => [], player2 => [card2, card1]}
    else
      {player1 => [], player2 => []}
      #draw(player1, player2)
    end
  end

  # def draw(player1, player2)
  #   deck_p1 = player1.hand
  #   deck_p2 = player2.hand

  #   draw_battle = []
  #   # draw_battle << 3.times { player1.hand.deal_card }
  #   # draw_battle << 3.times { player2.hand.deal_card }

  #   draw_p1 = deck_p1.deal_card
  #   draw_p2 = deck_p2.deal_card

  #   result = WarAPI.play_turn(player1, draw_p1, player2, draw_p2)
  #   result[player1].each { |v| deck_p1.add_card(v) ; puts "player 1 won a #{v} for his hand" }
  #   result[player2].each { |v| deck_p2.add_card(v) ; puts "player 1 won a #{v} to his hand" }

  #   if result[player1] = []
  #     draw_battle.each { |v| deck_p1.add_card(v) ; puts "player 1 won a #{v} for his hand" }
  #   else
  #     draw_battle.each { |v| deck_p2.add_card(v) ; puts "player 1 won a #{v} to his hand" }
  #   end
  # end

end

# binding.pry
