User.destroy_all 
Game.destroy_all
Theme.destroy_all  

u1 = User.create(username: "2fast2furious")
u2 = User.create(username: "dumdum")
u3 = User.create(username: "MuchFast_VeryType")
u4 = User.create(username: "FastButWrong")
u5 = User.create(username: "RightButSlow")

# t1 = Theme.create(name: "the office", words: "Bears Beets Battlestar Galactica, Agent Michael Scarn, I am a little stitious, God is in this Chili's., Jim died of boredom., Eyes are the groin of the face., Did I stutter?, Do I need to be liked?, Who is Justice Beaver?, Sorry I annoyed you with my friendship., Dwight! You ignornat slut!, That's what she said." )
# t2 = Theme.create(name: "coding", words: "ActiveRecord::Migration, def initialize, git pull origin master, attr_accessor, attr_reader, attr_writer, git commit -m 'I am fast', has_many :typos, belongs_to :winner, ActiveRecord::Base, \#{speedy}, Fruit is not a grape.")
# t3 = Theme.create(name: "numbers", words: "34297, 00000000, 2134, 073693, 13936946, 387, 123456789, 8260038, 110986111, 27360163, 7375946, 657, 0987654321, 74967200, 74936540, 85937564, 86473659, 75927659, 274037, 47207475, 549327, 459245, 4702634507, 471111118, 840273, 76769403")
# t4 = Theme.create(name: "runtime terror", words: "Blake Gaal, Caleb Rutland, Cornelius Omowaiye, Georgii Garvilchik, Gian Moran, Placido Wang, Raul Sanchez, Jeannie Kim, Somaia Khalil, Stephen Williams, Steven Ngyuen, Vidhi Sharma, Lauren Bauml, Mitchell Alton, Paul Hoffart, Vien Pham")
# t5 = Theme.create(name: "jibberish", words: "Bzidk anfoqm nfur!!, aoiemm iapue, boqle furken pahblr, panifl aienaloi, Aoauw Piwnt Yowub Uabogur, ABHP ABHP, PLEWNFO KILEM NOCG, Oao Poubmu, Aiubg Upiwnb Risznwn Touowb, POAAAAAAAAA, muaopue mhocw b, baogurb pibvn, enoayeu aounvwou nahov")
# t6 = Theme.create(name: "Russian", words: "Dobraye ootro, Spaseeba preekrasna!, Bal'shoye spaseeba, Neechevo srashnava, Vi gavareetye, Kak pazhivayesh?, Ya plokha gavaryoo, Prasteete, Neeploha!")
# t7 = Theme.create(name: "Star Wars", words: "force, Jedi Master, Sithe Lord, lightsaber, Naboo, X-win, Death Star, May the force be with you")

t1 = Theme.create(name: "the office", words: "Bears, Beets, Chili, Jim, Dwight, Angela, Meredith, Stanley, Paper, Beesly, Halpert, Kevin, Andy, Creed, Kelly, Holly, Creed, Sales, Sabre, Pyramid, Scranton, Jello, Astrid")
t2 = Theme.create(name: "coding", words: "ActiveRecord, initialize, origin, attr_accessor, attr_reader, attr_writer, has_many, belongs_to, \#{speedy}, GitHub, C#, JavaScript, Ruby, mongoDB, SQLite3, binding.pry, Sinatra, React, Redux, NodeJS, AngularJS, end, elsif")
t3 = Theme.create(name: "numbers", words: "34297, 0000000, 2134, 0793, 13946, 387, 12345, 60038, 110981, 20163, 73756, 657, 09821, 7490, 74940, 8754, 86459, 7599, 27037, 47475, 549327, 459245, 47507, 4711118, 84027, 76703") #Array.new(20){rand(1..100000)}
t4 = Theme.create(name: "runtime terror", words: "Blake, Caleb, Cornelius, Georgii, Gian, Placido, Raul, Jeannie, Somaia, Stephen, Steven, Vidhi, Mitchell, Paul, Vien")
t5 = Theme.create(name: "jibberish", words: "Bzidk!!, aoiemm, boqler, panii, Aoogur, ABHP, PLEWNFO, Poubmu, Aiubg, POAAAA, muaopue, baogun, enoyeu, dsfi, oanve, obtmerm, dosueo, anr, adns")
t6 = Theme.create(name: "star wars", words: "Force, Jedi, Troopers, lightsaber, Naboo, X-win, Leia, Skywalker, Chewbacca, R2-D2, Greedo, Darklighter, Stormtrooper, Kylo")
t7 = Theme.create(name: "russian", words: "Dobraye, Spaseeba, Bal'shoye, Neechevo, Gavareetye, Pazhivayesh?, Gavaryoo, Prasteete, Neeploha!")



Game.create(user_id: u1.id, theme_id: t1.id, score: 20)
Game.create(user_id: u1.id, theme_id: t2.id, score: 10)
Game.create(user_id: u1.id, theme_id: t3.id, score: 8)
Game.create(user_id: u1.id, theme_id: t4.id, score: 11)


Game.create(user_id: u2.id, theme_id: t1.id, score: 9)
Game.create(user_id: u2.id, theme_id: t2.id, score: 10)
Game.create(user_id: u2.id, theme_id: t7.id, score: 20)
Game.create(user_id: u2.id, theme_id: t6.id, score: 16)
Game.create(user_id: u2.id, theme_id: t5.id, score: 65)



Game.create(user_id: u3.id, theme_id: t4.id, score: 20)
Game.create(user_id: u3.id, theme_id: t3.id, score: 15)
Game.create(user_id: u3.id, theme_id: t2.id, score: 5)
Game.create(user_id: u3.id, theme_id: t7.id, score: 20)

Game.create(user_id: u4.id, theme_id: t6.id, score: 10)
Game.create(user_id: u4.id, theme_id: t5.id, score: 12)
Game.create(user_id: u4.id, theme_id: t4.id, score: 14)


Game.create(user_id: u4.id, theme_id: t3.id, score: 18)
Game.create(user_id: u4.id, theme_id: t2.id, score: 12)
Game.create(user_id: u4.id, theme_id: t1.id, score: 5)













