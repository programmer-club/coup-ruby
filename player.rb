module Player
  def get_coins()
    @coins
  end

  def get_hand()
    @hand
  end

  def to_s()
    "coins: " + get_coins.to_s + " hand: " + get_hand.join(", ")
  end

  def add_coins(amt)
    @coins += amt
  end
end