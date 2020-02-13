require_relative '../config/environment'

$prompt = TTY::Prompt.new
$font = TTY::Font.new(:starwars)
$pastel = Pastel.new


def user_login
    user_list = User.all.map {|user| user.username}
    user = $prompt.select($pastel.yellow("Select Username"), ["new_user", user_list.sort_by{|user| user.downcase}].flatten, filter: true)
    if user == "new_user"
        new_user = $prompt.ask('enter username') do |username|
            username.required true
            username.validate {|name| User.usernames.include? name}
            username.validate /\w/
        end
        user = User.create(username: new_user).username
    end
    @current_user = User.find_by(username: user)
end

def action
    $prompt.select($pastel.yellow("Watchu Wanna Do?"), filter: true) do |action|
        action.choice 'start new game', -> {new_game}
        action.choice 'checkout stats', -> {see_stats}
        action.choice 'exit', -> {exit_game}
    end
end

def select_theme
    theme = $prompt.select("pick a theme", Theme.all.map{|theme| theme.name}, filter: true)
    @current_theme = Theme.find_by(name: theme)
end

def new_game
    error = $pastel.red.bold.detach
    words = select_theme.words.split(", ")
    game_time = 30
    typed_words = 0
    # typed_words = []
    now = Time.now
    loop do
        if Time.now < now + game_time
            loop do 
                typing_prompt = words.sample
                play = $prompt.ask(typing_prompt, timeout: 3)
                if play == typing_prompt && Time.now < now + game_time
                    typed_words += 1
                    break
                elsif Time.now > now + game_time
                    puts $pastel.yellow("TIMES UP!!")
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
    # score = (typed_words.join(" ").split(" ").count.to_f / game_time.to_i * 60).to_i
    score = (typed_words.to_f / game_time.to_i * 60).to_i
    Game.create(score: score, user_id: @current_user.id, theme_id: @current_theme.id)
    print $pastel.yellow("YOUR SPEED: ") 
    puts $pastel.blue("#{score} WPM")
    puts $pastel.yellow("TOP SPEED FOR #{@current_theme.name.upcase}: #{@current_theme.high_score.score} WPM")
    game_next
end

def game_next
    $prompt.select("watchu wanna do next?", filter: true) do |action|
        action.choice 'play again', -> {new_game}
        action.choice 'check stats', -> {see_stats}
        action.choice 'exit', -> {exit_game}
    end
end

def see_stats
    $prompt.select($pastel.yellow("Make Your Selection"), filter: true) do |stat|
        stat.choice 'your high score', -> {my_high_score}
        stat.choice 'your rankng', -> {my_global_rank}
        stat.choice 'high scores', -> {User.top_3}
        stat.choice 'leader board', -> {Theme.leaders}
        # stat.choice 'theme plays', -> {Theme.plays}
        # stat.choice 'most active players', -> {User.most_active}
        # stat.choice 'fastest players', -> {User.print_fastest_users}
    end
    stat_next
end

def stat_next
    $prompt.select($pastel.yellow("Watchu Wanna Do Next?"), filter: true) do |action|
        action.choice 'go back', -> {see_stats}
        action.choice 'play game', -> {new_game}
        action.choice 'exit', -> {exit_game}
    end
end

def my_high_score
    if @current_user.games == []
        puts $pastel.blue("looks like you havent played a game, play!")
        new_game
    else
        @current_user.print_high_score
    end
end

def my_global_rank
    if @current_user.games == []
        puts $pastel.blue("looks like you havent played a game, play you peasant!")
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
    user_login
    action
end

# play



