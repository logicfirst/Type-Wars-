class User < ActiveRecord::Base
    has_many :games
    has_many :themes, through: :games

    def high_score
        # self.games.maximum(:score)
        top = self.games.order("score DESC").first
        puts "#{self.username} - #{top.score} WPM"
    end

    def top_3
        # Game.maximum(:score)
        top = Game.order("score DESC").first(3)
        puts "1st #{User.find(user_id=top[0].user_id).username} - #{top[0].score} WPM"
        puts "2nd #{User.find(user_id=top[1].user_id).username} - #{top[1].score} WPM"
        puts "3rd #{User.find(user_id=top[2].user_id).username} - #{top[2].score} WPM"
    end
end

