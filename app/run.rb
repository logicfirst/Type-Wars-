require_relative '../config/environment'

$prompt = TTY::Prompt.new

# to escape game return to main menu press esc ?
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
        action.choice 'exit', -> {exit_game}
    end
end

def select_theme
    theme = $prompt.select("", Theme.all.map{|theme| theme.name})
    @current_theme = Theme.find_by(name: theme)
end

def new_game
    words = select_theme.words.split(", ")
    game_time = 20
    typed_words = 0
    now = Time.now
    loop do
        if Time.now < now + game_time
            loop do 
                word = words.sample
                play = $prompt.ask(word)
                if play == word
                    typed_words += 1
                    break
                end
            end 
        else 
            break
        end
    end
    score = typed_words / game_time * 60
    Game.create(score: score, user_id: @current_user.id, theme_id: @current_theme.id)
    puts "TIMES UP!"
    puts "YOUR SPEED WAS #{score} WORDS PER MINUTE"
    game_next
end

def see_stats
    @current_user 
    $prompt.select("Make your selection") do |stat|
        stat.choice 'High Score', -> {@current_user.my_high_score}
        stat.choice 'Top Players', -> {Game.top_3}
        stat.choice 'Global Rankng', -> {@current_user.global_rank}
    end
    stat_next
end

def stat_next
    $prompt.select("watchu wanna do next?") do |action|
        action.choice 'go back', -> {see_stats}
        action.choice 'play game', -> {new_game}
        action.choice 'exit', -> {exit_game}
    end
end

def game_next
    $prompt.select("watchu wanna do next?") do |action|
        action.choice 'play again', -> {new_game}
        action.choice 'check stats', -> {see_stats}
        action.choice 'exit', -> {exit_game}
    end
end

def exit_game
    $prompt.say("YO DAWG THANKS FOR PLAYING")
    exit
end

def play
    $prompt.say("YO DAWG WELCOME TO TYPE WARS")
    user_login
    action
end

play



