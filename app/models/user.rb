class User < ActiveRecord::Base
    has_many :games
    has_many :themes, through: :games

    def high_score
        # self.games.maximum(:score)
        @top = self.games.order("score DESC").first
    end

    def my_high_score
        puts "#{self.username} - #{@top.score} WPM"
    end

    def top_3
        # Game.maximum(:score)a
        top = self.order("score DESC").first(3)
        puts "1st #{User.find(user_id=top[0].user_id).username} - #{top[0].score} WPM"
        puts "2nd #{User.find(user_id=top[1].user_id).username} - #{top[1].score} WPM"
        puts "3rd #{User.find(user_id=top[2].user_id).username} - #{top[2].score} WPM"
    end

    def rank_array

    rank = User.all.select {|user| user.games != []}
    rank = rank.sort_by {|user| user.high_score.score}
    @rank = rank.map {|user| user.high_score}.reverse
    
    # puts "You are ranked #{rank.index} out of #{rank.length}"
    end

    def global_rank
        i = rank_array.find {|rank| rank.user_id == self.id}
        puts "You are ranked #{@rank.index(i)} out of #{@rank.length}."
    end
end

