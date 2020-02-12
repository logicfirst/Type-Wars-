

class User < ActiveRecord::Base
    has_many :games
    has_many :themes, through: :games

    def high_score
        @top_score = self.games.order("score DESC").first
    end

    def print_high_score
        high_score
        puts "#{self.username} - #{@top_score.score} WPM"
    end

    # def self.high_scores
    #     cleaned_users = User.all.select {|user| user.games != []}
    #     sorted_users = cleaned_users.sort_by {|user| user.high_score.score}
    #     high_scores = sorted_users.map {|user| [user.username, user.high_score.score]}
    #     puts "1st #{high_scores[0][0]} - #{high_scores[0][1]} WPM"
    #     puts "2nd #{high_scores[1][0]} - #{high_scores[1][1]} WPM"
    #     puts "3rd #{high_scores[2][0]} - #{high_scores[2][1]} WPM"
    # end =======> using top_3 instead 

    def self.top_3
        top = Game.order("score DESC").first(3)
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

    def self.clean_users
        self.all.each do |user|
            if user.games == []
                user.destroy
            end
        end
        
    end


    def self.most_active
        sorted = self.all.sort_by{|user| user.games.length}
        puts "#{sorted[0].username} - #{sorted[0].games.length} games"
        puts "#{sorted[1].username} - #{sorted[1].games.length} games"
        puts "#{sorted[2].username} - #{sorted[2].games.length} games"
    end
end

