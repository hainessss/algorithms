require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'


describe Card do
  describe 'intialize' do
    it 'is a card with rank, value, and suit' do
      card = Card.new('J', 11, 'Spades')

      expect(card.rank.downcase!).to eq 'j'
      expect(card.value).to eq 11
      expect(card.suit.downcase!).to eq 'spades'
      expect(card).to be_a(Card)
    end
  end
end

describe Deck do
  let(:deck1) { Deck.new }

  describe 'intialize' do
    # let(:deck) { Deck.new }
    it "to be an array" do
      expect(deck1.deck).to be_a(Array)
    end
  end

  describe 'add_card' do
    it "should add one card to store" do
      deck1.create_52_card_deck
      added_card = deck1.deal_card
      deck1.add_card(added_card)
      # binding.pry
      expect(deck1.store[0]).to eq added_card
    end
  end

  describe 'shuffle' do
    it "should randomize the deck" do
      deck1.create_52_card_deck
      before_shuffled = deck1.deck
      after_shuffled = deck1.shuffle

      expect(after_shuffled).not_to eq before_shuffled
    end
  end

  describe '.deal_card' do
    it "should return the top card of the deck" do
      deck1.create_52_card_deck
      dealt_card = deck1.deck[0]
      expect(deck1.deal_card).to eq dealt_card
    end

    # it "should store the cards in a placeholder array" do
    #   deck1.create_52_card_deck
    #   51.times { deck1.deal_card }
    #   expect(deck1.store.length).to eq 51
    # end

    # it "should circle through the deck" do
    #   deck1.create_52_card_deck
    #   dealt_card = deck1.deck[0]
    #   52.times { deck1.deal_card }
    #   # binding.pry
    #   expect(deck1.deal_card).to eq dealt_card
    # end
  end

  describe '.create_52_card_deck' do
    it 'is an array with 52 cars' do
      deck1.create_52_card_deck
      expect(deck1.deck.length).to eq 52
    end
  end
end

 # binding.pry

describe Player do
  describe 'intialize' do
    it 'should have a name and a deck' do
      pete = Player.new('pete')

      expect(pete.name).to eq 'pete'
      expect(pete.hand).to be_a Deck
    end
  end
end

describe War do
  describe 'intialize' do
    it 'should take in two players' do
      game1 = War.new('alex', 'pete')

      expect(game1.player1.name).to eq 'alex'
      expect(game1.player2.name).to eq 'pete'
      expect(game1.player1).to be_a Player
      expect(game1.player2).to be_a Player
    end

    it 'should shuffle and pass out the cards to each player' do
      game1 = War.new('alex', 'pete')
      # binding.pry
      expect(game1.player1.hand.deck.length).to eq 26
      expect(game1.player1.hand.deck.length).to eq 26
    end
  end

  describe 'play_game' do
    it 'determines a winner and redelegates cars' do
      game1 = War.new('alex', 'pete')
      game1.player1.hand.deck = [Card.new('J', 11, 'spades')]
      game1.player2.hand.deck = [Card.new('2', 2, 'spades')]
      game1.play_game

      expect(game1.player1.hand.deck.length).to eq 2
    end

    it 'ends the game when one player is out of cards' do
      game1 = War.new('alex', 'pete')
      game1.player1.hand.deck = [Card.new('J', 11, 'spades')]
      game1.player2.hand.deck = [Card.new('2', 2, 'spades')]
      # binding.pry
      game1.play_game
      expect(game1.play_game).to eq game1.player1
    end
  end
end

describe WarAPI do
  describe 'play_turn' do
  end
end
