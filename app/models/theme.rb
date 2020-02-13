class Theme < ActiveRecord::Base
    has_many :games
    has_many :users, through: :games

    def self.plays
        Theme.all.each do |theme|
            print $pastel.white("#{theme.name}: ")
            puts $pastel.blue("#{theme.games.length} plays")
        end
    end

    def high_score
        self.games.order('score DESC').first
    end

    def self.leaders
        self.all.each do |theme|
            print $pastel.white("#{theme.name}: ")
            print $pastel.blue("#{User.find(theme.high_score.user_id).username}")
            puts $pastel.white(" - #{theme.high_score.score} WPM")
        end
    end

end