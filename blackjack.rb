module BJ

  # TODO 
  # - ocassionally stops working

  def BJ.deck
    ace = 11
    jack = queen = king = 10
    suit = [2,3,4,5,6,7,8,9, 10, ace, jack, queen, king]
    suit * 4
  end

  def BJ.shuffled_deck
    BJ.deck.shuffle!
  end 

  def BJ.deal 
    @hand = BJ.shuffled_deck.pop(2)
    @dealer = BJ.shuffled_deck.pop(2)
  end

  def BJ.blackjack
    BJ.deal
    until BJ.your_total > 21 do 
      BJ.stick_or_twist
    end
    BJ.dealer_turn
    BJ.finish_game
  end

  def BJ.twist
    BJ.shuffled_deck.pop(1)
  end

  def BJ.stick_or_twist
    puts "You have #{BJ.your_total}. Stick or twist?" 
    @ans = gets.chomp
    if @ans == "twist"
      @hand = @hand + BJ.twist
    elsif @ans == "stick"
      BJ.dealer_turn
      BJ.winning
    end
  end

  def BJ.dealer_turn
   while BJ.dealers_total < 18 || BJ.dealers_total > 21
      @dealer = @dealer + BJ.twist
    end
  end  

  def BJ.your_total
    @hand.reduce(:+)
  end

  def BJ.dealers_total
    @dealer.reduce(:+)
  end

  def BJ.winning
    if BJ.your_total > 21
      exit(puts "You have #{BJ.your_total}. Bust!")
    elsif BJ.your_total > BJ.dealers_total
      exit(puts "#{BJ.your_total} beats #{BJ.dealers_total}. You win!")
    elsif BJ.your_total == BJ.dealers_total
      exit(puts "You both have #{BJ.your_total}. It's a draw")
    else
      exit(puts "#{BJ.dealers_total} beats #{BJ.your_total}. You lose!")
    end
  end

  def BJ.finish_game
    BJ.winning    
    BJ.deal.each { |card| BJ.deck << card }
  end
end