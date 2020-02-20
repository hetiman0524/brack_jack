require "./deck"
require "./card"
require "./player"
require "./dealer"

class Blackjack

  def start
    puts <<~text
    ----------------------------------
    |                                |
    |           BLACK JACK           |
    |                                |
    ----------------------------------
    text

    while true
      deck = Deck.new
      player = Player.new
      dealer = Dealer.new

      bust_flag = 0

      puts <<~text
      まずはディーラー、プレイヤー共に
      デッキからカードを2枚引きます
      text

      # 生成したdeckからカードを引いてくる
      dealer.first_draw_dealer(deck)

      # dealerのポイントを計算
      @dealer_point = dealer.point_dealer
 
      # 生成したdeckからカードを引いてくる
      player.first_draw_player(deck)

      # playerのポイントを計算
      @player_point = player.point_player
      player_use_11 = player.count_11

      if player_use_11 == 0
        puts <<~text
        あなたの手札の合計点数は#{@player_point}です。
        ----------------------------------
        text
      else
        puts <<~text
        あなたの手札の合計点数は#{@player_point}、もしくは#{@player_point-10}です。
        ----------------------------------
        text
      end

      # PlayerがStandを選択するまでカードを引き続けるループ処理
      while true
        puts <<~text
        あなたの行動を選択してください
        1.Hit 2.Stand
        text

        action = gets.chomp.to_i

        if action == 1
          # ユーザがHitを選択。デッキからカードを引く
          player.draw_player(deck)

          # playerのポイントを計算
          @player_point = player.point_player
          puts <<~text
          あなたの手札の合計点数は#{@player_point}です。
          ----------------------------------
          text

          if @player_point >= 22

            # playerのポイントが22を超えるとバースト。即ゲーム終了
            bust("あなた")

            # ゲームを終了するので、breakではなくreturn
            bust_flag = 1
            break
          end
        
        elsif action == 2
          # ユーザがStandを選択。ループ処理を抜ける
          break
        else
          # ユーザが指定数以外を入力。ループ継続
          puts <<~text
          ----------------------------------
          error ： 1か2を入力してください
          ----------------------------------
          text
        end
      end

      if bust_flag == 0
        # ディーラーのポイントが17以上になるまでカードを引き続ける
        while @dealer_point <= 16

          # デッキからカードを1枚引く
          dealer.draw_dealer(deck)

          # dealerポイントを計算
          @dealer_point = dealer.point_dealer
        end

        puts <<~text
        ディーラーがカードを引き終わりました
        勝敗判定に参りましょう
        text

        # judgeメソッドにて処理
        judge(player, dealer)

      end

      puts <<~text
      ----------------------------------
      1.ゲームを続ける 2.ゲームをやめる
      text
      continue = gets.chomp.to_i
      if continue == 1

        puts <<~text
        ゲーム続行
        text

      elsif continue == 2
        puts <<~text
        ゲーム終了
        text
        break
      else
        puts <<~text
        ----------------------------------
        error ： 1か2を入力してください
        ----------------------------------
        text
      end

    end

  end

  def judge(player, dealer)
    # ディーラーの手札公開、合計点数を表示
    dealer.hands_show_dealer
    @dealer_point = dealer.point_dealer
    puts <<~text
    ディーラーの手札の合計点数は#{@dealer_point}です。
    ----------------------------------
    text

    # プレイヤーの手札公開、合計点数を表示
    player.hands_show_player
    @player_point = player.point_player
    puts <<~text
    あなたの手札の合計点数は#{@player_point}です。
    ----------------------------------
    text

    if @playr_point == @dealer_point
      puts <<~text
      -----------------------------------
      合計得点が同点となりました。引き分けです。
      text

    elsif @playr_point == 21
      puts <<~text
      -----------------------------------
      ブラックジャックです。おめでとうございます。あなたの勝ちです。
      text

    elsif @dealer_point >= 22
      puts <<~text
      -------------------------------------
      ディーラーがバーストしました。
      おめでとうございます。あなたの勝ちです！
      text

    # ディーラーの点数がプレイヤーの点数より高い→ディーラーの勝ち
    elsif @dealer_point > @player_point
      puts <<~text
      -------------------------------------
      ディーラーの勝利。あなたの負けです。
      text

    # ディーラーの点数がプレイヤーの点数より低い→プレイヤーの勝ち
    else
      puts <<~text
      ---------------------------------------
      おめでとうございます。あなたの勝ちです。
      text
    end
  end

# ユーザがバーストした際の処理
  def bust(name)
    puts <<~text
    バーストしました。#{name}の負けです
    ---------money_information--------
    text
  end
end
