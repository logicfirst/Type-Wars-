require_relative '../config/environment'

$prompt = TTY::Prompt.new

# to logout press esc 
# prompt.keypress("Press space or enter to continue", keys: [:space, :return])


def user_login
    user_list = User.all.map {|user| user.username}
    user = $prompt.select("select username", ["new_user", user_list.sort_by{|user| user.downcase}].flatten, filter: true)
    if user == "new_user"
        new_user = $prompt.ask('enter username') do |username|
            username.required true
            username.validate /\w/
        end
        user = User.create(username: new_user).username
    end
    @current_user = User.find_by(username: user)
end

def action
    $prompt.select("watchu wanna do?") do |action|
        action.choice 'start new game', -> {new_game}
        action.choice 'checkout stats', -> {see_stats}
    end
end


def see_stats
    @current_user 
    $prompt.select("Make your selection") do |stat|
        stat.choice 'High Score', -> {@current_user.high_score}
        stat.choice 'Top Players', -> {Game.top_3}
        stat.choice 'Global Rankng', -> {@current_user.global_rank}
    end
end

def select_theme
    theme = $prompt.select("", Theme.all.map{|theme| theme.name})
    @current_theme = Theme.find_by(name: theme)
end

def new_game
    @current_user 
    @current_theme 
    words = select_theme.words.split(", ")
    score = 0 
    now = Time.now
    counter = 20
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
        else 
            break
        end
    
    end
    Game.create(score: score, user_id: @current_user.id, theme_id: @current_theme.id)
    puts "TIMES UP!"
    puts "YOUR SPEED WAS #{score*3} WORDS PER MINUTE"
end



def stats
    puts "stats"
end



def play
    $prompt.say("YO WELCOME TO TYPE WARS")
    user_login
    action
end

play



