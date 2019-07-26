class BotPlayer
  include Bot

  def get_move(opponent) # TODO: only <!> if it is a bluff
    puts "Your hand: " + @hand.join(", ")
    puts "[1] Coup"
    puts "[2] Income"
    puts "[3] Assassinate " + (if @hand.include? "Assassin" then "" else "<!>" end)
    puts "[4] Exchange " + (if @hand.include? "Ambassador" then "" else "<!>" end)
    puts "[5] Steal " + (if @hand.include? "Captain" then "" else "<!>" end)
    puts "[6] Tax " + (if @hand.include? "Duke" then "" else "<!>" end)
    print "Select a move: "

    return gets.to_i
  end

  def get_cards(cards_drawn)
    puts "[1] " + @hand[0].to_s
    puts "[2] " + @hand[1].to_s
    puts "[3] " + cards_drawn[0].to_s
    puts "[4] " + cards_drawn[1].to_s
    print "Select the first card you would like: "

    total = @hand + cards_drawn
    card1 = gets.to_i - 1
    print "Select the second card you would like: "
    card2 = gets.to_i - 1

    while card1 == card2
      print "You may not select the same card twice, select again: "
      card2 = gets.to_i
    end

    return total[card1], total[card2]
  end

  def choose_to_block_assassin(opponent)
    puts "[1] Block with Contessa " + (if @hand.include? "Contessa" then "" else "<!>" end)
    puts "[2] Allow"
    print "Select a move: "

    return gets.to_i
  end

  def choose_to_block_captain(opponent)
    puts "[1] Block with Ambassador " + (if @hand.include? "Ambassador" then "" else "<!>" end)
    puts "[2] Block with Captain " + (if @hand.include? "Captain" then "" else "<!>" end)
    puts "[3] Allow"
    print "Select a move: "

    return gets.to_i
  end

  def challenge(opponent, action)
    puts "[1] Challenge"
    puts "[2] Allow"
    print "Select a move: "

    return gets.to_i
  end

  def choose_card_to_flip
    puts "[1] " + @hand[0].to_s
    puts "[2] " + @hand[1].to_s
    print "Select which to flip: "

    return @hand[gets.to_i - 1]
  end
end
