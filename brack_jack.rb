require './card'
require './deck'
require './player'

def run_game
  # 初期手札2枚の準備,手札公開,得点表示
  deck = Deck.new
  deck.shuffle
  player = Player.new
  player.first_draw(deck)
  player.score_count
  dealer = Dealer.new
  dealer.first_draw(deck)
  dealer.score_count
  
  while true do
end