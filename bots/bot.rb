require_relative '../player'
require_relative '../enums'

module Bot
  include Player

  def initialize(coins, hand)
    @coins = coins
    @hand = hand
    @revealed_cards = []
  end

  def get_move(opponent)
    if get_coins >= 7
      return Move::Coup
    end

    Move::Income
  end

  def get_cards(cards_drawn)
    @hand
  end

  def choose_to_block_assassin(opponent)
    BlockAssassin::Allow
  end

  def choose_to_block_captain(opponent)
    BlockCaptain::Allow
  end

  def challenge(opponent, action)
    ChallengeQ::Allow
  end

  def choose_card_to_flip
    @hand[0]
  end

  def flip_card (deck, card)
    @hand.delete_elements_in [card]
    @revealed_cards << card
    deck << card
  end

  def add_card(i)
    @hand << i
  end
end
