User.destroy_all 
Game.destroy_all
Theme.destroy_all  

u1 = User.create(username: "2fast2furious")
u2 = User.create(username: "dumdum")
u3 = User.create(username: "MuchFast_VeryType")
u4 = User.create(username: "FastButWrong")
u5 = User.create(username: "RightButSlow")

t1 = Theme.create(name: "The Office", words: "Bears, Beets, Battle Star Gallactica, Paper" )
t2 = Theme.create(name: "Coding", words: "Ruby, ActiveRecord, initialize, rakefile, JavaScript")
t3 = Theme.create(name: "Zoo", words: "Giraffe, Elephant, Rhinocerous")

Game.create(user_id: u1.id, theme_id: t1.id, score: 65)
Game.create(user_id: u1.id, theme_id: t2.id, score: 50)

Game.create(user_id: u2.id, theme_id: t1.id, score: 43)
Game.create(user_id: u2.id, theme_id: t2.id, score: 60)
Game.create(user_id: u2.id, theme_id: t2.id, score: 65)


Game.create(user_id: u3.id, theme_id: t3.id, score: 50)
Game.create(user_id: u3.id, theme_id: t1.id, score: 50)

Game.create(user_id: u4.id, theme_id: t1.id, score: 2)

Game.create(user_id: u4.id, theme_id: t3.id, score: 3)












