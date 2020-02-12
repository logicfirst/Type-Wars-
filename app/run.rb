require_relative '../config/environment'

$prompt = TTY::Prompt.new
$font = TTY::Font.new(:starwars)
$pastel = Pastel.new

# to escape game return to main menu press esc ?
# prompt.keypress("Press space or enter to continue", keys: [:space, :return])

def exit_on_esc
    $prompt.on(:keypress) do |event|
        if event.value == 'esc'
            $prompt.trigger(exit)
        end
    end
end

def user_login
    exit_on_esc
    user_list = User.all.map {|user| user.username}
    user = $prompt.select($pastel.yellow("Select Username"), ["new_user", user_list.sort_by{|user| user.downcase}].flatten, filter: true)
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
    $prompt.select($pastel.yellow("Watchu Wanna Do?")) do |action|
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
    error = $pastel.red.bold.detach
    words = select_theme.words.split(", ")
    game_time = 20
    typed_words = 0
    now = Time.now
    loop do
        if Time.now < now + game_time
            loop do 
                word = words.sample
                play = $prompt.ask(word, timeout: 3)
                if play == word && Time.now < now + game_time
                    typed_words += 1
                    break
                elsif Time.now > now + game_time
                    puts "TIMES UP!!"
                    break 
                else 
                    puts error.('Error!')
                    break 
                end
            end 
        else 
            break
        end
    end
    score = (typed_words.to_f / game_time.to_i * 60).to_i
    Game.create(score: score, user_id: @current_user.id, theme_id: @current_theme.id)
    puts "YOUR SPEED WAS #{score} WORDS PER MINUTE"
    game_next
end

def game_next
    $prompt.select("watchu wanna do next?") do |action|
        action.choice 'play again', -> {new_game}
        action.choice 'check stats', -> {see_stats}
        action.choice 'exit', -> {exit_game}
    end
end

def see_stats
    $prompt.select($pastel.yellow("Make Your Selection")) do |stat|
        stat.choice 'your high score', -> {my_high_score}
        stat.choice 'top players', -> {User.top_3}
        stat.choice 'global rankng', -> {my_global_rank}
        stat.choice 'theme plays', -> {Theme.plays}
        stat.choice 'most active users', -> {User.most_active}
    end
    stat_next
end

def stat_next
    $prompt.select($pastel.yellow("Watchu Wanna Do Next?")) do |action|
        action.choice 'go back', -> {see_stats}
        action.choice 'play game', -> {new_game}
        action.choice 'exit', -> {exit_game}
    end
end

def my_high_score
    if @current_user.games == []
        puts "looks like you havent played a game, play!"
        new_game
    else
        @current_user.print_high_score
    end
end

def my_global_rank
    if @current_user.games == []
        puts "looks like you havent played a game, play you peasant!"
        new_game
    else
        @current_user.global_rank
    end
end

def exit_game
    puts $pastel.yellow($font.write("                                           GOOD"))
    puts $prompt.say("                                                   YO DAWG, THANKS FOR PLAYING!")
    puts $pastel.yellow($font.write("                                  BYE    (^_^)"))
    User.clean_users
    exit
end

def play
    puts $pastel.yellow($font.write("                                           TYPE"))
    puts $prompt.say("                                                          YO DAWG, WELCOME!")
    puts $pastel.yellow($font.write("                                       WARS"))
    # exit_on_esc
    user_login
    action
end

play



