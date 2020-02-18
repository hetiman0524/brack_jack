class Dealer
  def initialize
    @hands = []
  end

  def first_draw_dealer(deck)
    card = deck.draw
    @hands << card
    card = deck.draw
    @hands << card

    puts <<~text
    ------------Dealer手札------------
     1枚目 ： #{card.show}
     2枚目 ： 伏せられている
    ----------------------------------
    text
    # 初回は2回なので再度繰り返す
    card = deck.draw
    @hands << card
  
  end

  # dealerの点数を表示
  def point_dealer
    # 点数の初期化
    dealer_point = 0
    # 手札のカードを一枚ずつ確認して点数を計算していく
    @hands.each do |draw_card|

      # カードに対して、pointメソッドを用いて点数を確認。それを点数に足していく
      dealer_point += draw_card.point
      #puts player_point
    end
    return dealer_point
  end

  # カードを1枚引く
  def draw_dealer(deck)
    card = deck.draw
    @hands << card
  end

  # 手札を1枚ずつ表示する
  def hands_show_dealer
    puts <<~text
    
    ------------Dealer手札------------
    text
    @hands.each.with_index(1) do |hand, i|
      puts " #{i}枚目 ： #{hand.show}"
    end
  end

end
