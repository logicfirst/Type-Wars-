class Game < ActiveRecord::Base
    belongs_to :user
    belongs_to :theme

    # def self.top_3
    #     top = self.order("score DESC").first(3)
    #     puts "1st #{User.find(user_id=top[0].user_id).username} - #{top[0].score} WPM"
    #     puts "2nd #{User.find(user_id=top[1].user_id).username} - #{top[1].score} WPM"
    #     puts "3rd #{User.find(user_id=top[2].user_id).username} - #{top[2].score} WPM"
    # end
end