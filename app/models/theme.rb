class Theme < ActiveRecord::Base
    has_many :games
    has_many :users, through: :games

    def self.plays
        Theme.all.each do |theme|
            puts "#{theme.name} has had #{theme.games.length} plays"
        end
    end
    
end