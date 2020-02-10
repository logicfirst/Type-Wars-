class User < ActiveRecord::Base
    has_many :games
    has_many :themes, through: :games
end