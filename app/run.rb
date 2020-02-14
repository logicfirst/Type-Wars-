require_relative '../config/environment'

$prompt = TTY::Prompt.new
$font = TTY::Font.new(:starwars)
$pastel = Pastel.new

# def exit_on_esc
#     $prompt.on(:keypress) do |event|
#         if event.value == 'esc'
#             $prompt.trigger(exit)
#         end
#     end
# end


def user_login
    # exit_on_esc
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
        action.choice 'start new game', -> {select_theme}
        action.choice 'checkout stats', -> {see_stats}
        action.choice 'exit', -> {exit_game}
    end
end

def select_theme
    theme = $prompt.select($pastel.yellow("pick a theme"), [$pastel.blue("Go Back"), Theme.all.map{|theme| theme.name}].flatten, filter: true)
    if theme == "\e[34mGo Back\e[0m"
        action
    else
        @current_theme = Theme.find_by(name: theme)
        new_game
    end
end

def new_game
    if @current_theme.name == "the office"
        switch_song
        play_music('music/the_office.mp3')
    elsif @current_theme.name == "coding"
        switch_song
        play_music('music/tetris.mp3')
    elsif @current_theme.name == "runtime terror"
        switch_song
        play_music('music/halo.mp3')
    elsif @current_theme.name == "russian"
        switch_song
        play_music('music/handball1.mp3')
    else @current_theme.name == "numbers" || "jibberish"
        switch_song
        play_music('music/mario64.mp3')
    end
    error = $pastel.red.bold.detach
    words = @current_theme.words.split(", ")
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
    score = (typed_words.to_f / game_time.to_f * 60).to_i
    Game.create(score: score, user_id: @current_user.id, theme_id: @current_theme.id)
    print $pastel.yellow("YOUR SPEED: ") 
    puts $pastel.blue("#{score} WPM")
    puts $pastel.yellow("TOP SPEED FOR #{@current_theme.name.upcase}: #{@current_theme.high_score.score} WPM")
    switch_song
    play_music('music/star_wars_theme.mp3')
    game_next
end

def game_next
    $prompt.select("watchu wanna do next?", filter: true) do |action|
        action.choice 'play again', -> {select_theme}
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
        action.choice 'play game', -> {select_theme}
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
    # pid = fork{ exec 'killall', "afplay" }
    stop_music_at_exit
    exit
end

def play_music(file)
    @pid = spawn( 'afplay', file )
end

def switch_song
    Process.kill "TERM", @pid
end

def stop_music_at_exit
    pid = fork{ system 'killall', 'afplay' }
end


def play
    play_music('music/star_wars_theme.mp3')
    puts $pastel.yellow($font.write("                                           TYPE"))
    puts $prompt.say("                                                          YO DAWG, WELCOME!")
    puts $pastel.yellow($font.write("                                       WARS"))
    user_login
    action
end

play



