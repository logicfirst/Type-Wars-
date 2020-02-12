class User < ActiveRecord::Base
    has_many :games
    has_many :themes, through: :games

    def high_score
        @top_score = self.games.order("score DESC").first
    end

    def print_high_score
        puts "#{self.username} - #{self.high_score.score} WPM"
    end

    def self.fastest_users
        cleaned_users = User.all.select {|user| user.games != []}
        sorted_users = (cleaned_users.sort_by {|user| user.high_score.score}).reverse
    end

    def self.print_fastest_users
        users = self.fastest_users
        puts "1st #{users[0].username} - #{users[0].high_score.score} WPM"
        puts "2nd #{users[1].username} - #{users[1].high_score.score} WPM"
        puts "3rd #{users[2].username} - #{users[2].high_score.score} WPM"
    end

    def self.top_3
        top = (Game.all.sort_by {|game| game.score}).reverse
        puts "1st #{User.find(top[0].user_id).username} - #{top[0].score} WPM"
        puts "2nd #{User.find(top[1].user_id).username} - #{top[1].score} WPM"
        puts "3rd #{User.find(top[2].user_id).username} - #{top[2].score} WPM"
    end


    def global_rank
        arr = User.fastest_users
        puts "You are ranked #{arr.index(self)+1} out of #{arr.length}."

    end

    

    def self.clean_users
        self.all.each do |user|
            if user.games == []
                user.destroy
            end
        end
        
    end

    def self.most_active
        sorted = (self.all.sort_by {|user| user.games.length}).reverse
        puts "#{sorted[0].username} - #{sorted[0].games.length} games"
        puts "#{sorted[1].username} - #{sorted[1].games.length} games"
        puts "#{sorted[2].username} - #{sorted[2].games.length} games"
    end

end

