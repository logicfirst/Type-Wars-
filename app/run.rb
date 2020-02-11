require_relative '../config/environment'

$prompt = TTY::Prompt.new
$timers = Timers::Group.new



def user_login
    user_list = User.all.map {|user| user.username}
    user = $prompt.select("select username", ["new_user", user_list].flatten)
    if user == "new_user"
        new_user = $prompt.ask('enter username')
        user = User.create(username: new_user).username
    end
    @current_user = User.find_by(username: user)
    # $user = user
end

def action
    $prompt.select("", %w(Start_New_Game See_Stats))
end


def see_stats
    @current_user 
    choices = {
        'High Score' => @current_user.high_score,
        # 'Top 3 Players' => Game
        
    }
    stat_choice = $prompt.select("Make your selection", choices)
end

def select_theme
    theme = $prompt.select("", Theme.all.map{|theme| theme.name})
    @current_theme = Theme.find_by(name: theme)
    #how to call this theme in later methods
end

def new_game
    @current_user 
    @current_theme 
    words = select_theme.words.split(", ")
    score = 0 
    now = Time.now
    counter = 20
    # binding.pry
    loop do
        if Time.now < now + counter
            loop do 
                word = words.sample
                play = $prompt.ask(word)
                if play == word
                    score += 1
                    break
                end
            
            end 
            # this doesnt count your mispelled words but just givess you a new word
        else 
            break
        end
    
    end
    Game.create(score: score, user_id: @current_user.id, theme_id: @current_theme.id)
    puts "TIMES UP!"
    puts "YOUR SPEED WAS #{score*3} WORDS PER MINUTE"

end


# def stats
 
# end


def play
    user_login
    action
    if action == "Start_New_Game"
        new_game
    else action == "See_Stats"
        see_stats
    end
end

play