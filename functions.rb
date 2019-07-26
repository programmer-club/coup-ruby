class Array
  def delete_elements_in(ary)
    ary.each do |x|
      if index = index(x)
        delete_at(index)
      end
    end
  end
end

# @param [Bot] player1
# @param [Bot] player2
# @param [String] pname
def parse_move (player1, player2, pname, p2name)
  action = player1.get_move player2
  if action == Move::Income
    player1.add_coins 1
    puts pname + " takes income!"
    return
  elsif action == Move::Coup
    if player1.get_coins >= 7
      player1.add_coins -7
      puts pname + " performs a Coup!"
      lost = player2.choose_card_to_flip
      puts p2name + " chooses to reveal " + lost + "!"
      player2.flip_card $deck, lost
      return
    else
      return
    end
  end

  check_challenge player1, player2, action, pname, p2name

  case action
  when Move::Assassinate
    assassinate player1, player2, pname, p2name
  when Move::Steal
    steal player1, player2, pname, p2name
  when Move::Exchange
    exchange.times player1, player2, pname, p2name
  when Move::Tax
    tax player1, player2, pname, p2name
  end
end

def check_challenge (player1, player2, action, pname, p2name)
  should_challenge = player2.challenge player1, action
  if should_challenge == ChallengeQ::Challenge
    puts p2name + " challenges!"
    card_from_action = case action
                       when Move::Assassinate
                         "Assassin"
                       when Move::Steal
                         "Captain"
                       when BlockCaptain::ClaimCaptain
                         "Captain"
                       when Move::Exchange
                         "Ambassador"
                       when BlockCaptain::ClaimAmbassador
                         "Ambassador"
                       when Move::Tax
                         "Duke"
                       when BlockAssassin::ClaimContessa
                         "Contessa"
                       end
    if player1.get_hand.include? card_from_action
      lost = player2.choose_card_to_flip
      puts p2name + " chooses to reveal " + lost + "!"
      player2.flip_card $deck, lost
      player1.get_hand.delete_elements_in [card_from_action]
      $deck << card_from_action
      player1.add_card $deck.pop
      $deck = $deck.shuffle

      puts p2name + " loses!"
      return true
    else
      lost = player1.choose_card_to_flip
      puts pname + " chooses to reveal " + lost + "!"
      player1.flip_card $deck, lost
      puts pname + " loses!"
      return false
    end
  end
end

# @param [Bot] player1
# @param [Bot] player2
# @param [String] pname
def assassinate (player1, player2, pname, p2name)
  puts pname + " performs an assassination!"
  if player1.get_coins >= 3
    player1.add_coins -3

    claim = player2.choose_to_block_assassin player1

    if claim != BlockAssassin::Allow
      if !check_challenge player1, player2, claim, pname, p2name
        return
      end
    end

    lost = player2.choose_card_to_flip
    puts p2name + " chooses to reveal " + lost + "!"
    player2.flip_card $deck, lost
  end
end

# @param [Bot] player1
# @param [Bot] player2
# @param [String] pname
def exchange (player1, player2, pname, p2name)
  puts pname + " performs an exchange!"

  new_cards = $deck.pop 2
  old_hand = player1.get_hand
  chosen_cards = player1.get_cards new_cards

  total = new_cards + old_hand
  total.delete_elements_in chosen_cards

  player1.instance_variable_set :@hand, chosen_cards
  $deck << total
  $deck = $deck.shuffle
end

# @param [Bot] player1
# @param [Bot] player2
# @param [String] pname
def tax (player1, player2, pname, p2name)
  puts pname + " takes tax!"
  player1.add_coins 3
end

# @param [Bot] player1
# @param [Bot] player2
# @param [String] pname
def steal (player1, player2, pname, p2name)
  puts pname + " steals!"

  claim = player2.choose_to_block_captain player1

  if claim != BlockCaptain::Allow
    if !check_challenge player1, player2, claim, pname, p2name
      return
    end
  end

  player1.add_coins 2
  player2.add_coins -2

  if player2.get_coins < 0
    player2.add_coins -player2.get_coins
  end
end
