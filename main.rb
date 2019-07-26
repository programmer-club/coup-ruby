require_relative 'player'
require_relative 'bots/bot'
require_relative 'bots/bot_player'
require_relative 'bots/bot_income'
require_relative 'functions'

$deck = %w{Assassin Ambassador Captain Contessa Duke} * 3

$deck = $deck.shuffle

player1 = BotPlayer.new(1, $deck.pop(2))
player2 = BotIncome.new(2, $deck.pop(2))

round = 1
winner = 0
has_player = player1.instance_of?(BotPlayer) || player2.instance_of?(BotPlayer)

while winner == 0
  if has_player
    puts "Player 1 has %d coins" % player1.get_coins.to_s
    puts "Player 2 has %d coins" % player2.get_coins.to_s
  else
    puts "Player 1: " + player1.to_s
    puts "Player 2: " + player2.to_s
  end

  parse_move player1, player2, "Player 1", "Player 2"
  parse_move player2, player1, "Player 2", "Player 1"

  if player1.get_hand.length == 0
    winner = 2
  elsif player2.get_hand.length == 0
    winner = 1
  end

  round += 1
end

print "After " + round.to_s + " rounds, "
puts "the winner is: player " + winner.to_s