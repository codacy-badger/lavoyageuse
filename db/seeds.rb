# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emails = %w(sarahfarrel.b@gmail.com faith.R@gmail.com june.hullard@yahoo.fr Celeste.in@gmail.com Steph.croods@girst.com Marge@simpson.com Shan@shen.cn helen.Christobale@world.co judith@hero.com)
password = "LVa123456"
first_names = %w(sarah faith june Céleste Stéphanie Marguerite Shan Helen Judith)
last_names = %w(Imbert Rimbaud Hullard Stonehood Dantepierre Aggrestuko Christobale Delacroix Gauthier)
phone = "0987654321"
addresses = [ "22 Rue de la Preceinte, Le Bouscat",
            "13 place Gambetta, Bordeaux",
            "135 cours du Médoc, Bordeaux",
            "25 rue Sainte Catherine, Bordeaux",
            "4 Avenue Jean Mermoz, Le Haillan",
            "6 Rue du Pradas, Mérignac",
            "9 Rue André Darbon, Bordeaux",
            "124 Rue Lucien Faure, Bordeaux",
            "65 Quai des Chartrons, Bordeaux"]
role = 1
sentences = ["J'aime le yoga et la cuisine,
              J'aime l'art et la danse,
              J'aime voyager et faire des rencontres,
              J'aimes les éléphants bleus et les chats loufoques,
              J'aime rire entre amis,
              J'aime me dire qu'il est bon de changer,
              Je serai votre meilleur hôte à Bordeaux,
              J'adore les sushis et les films de ninja,
              J'aime voir le monde et ses couleurs"]
photos = ["https://res.cloudinary.com/dfcsmghw4/image/upload/v1537346964/seed/Teenager-dies-after-rolling-onto-broken-iPhone-cable-in-her-sleep.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347615/seed/photo-1458662236860-b721a6735660.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347595/seed/photo-1463763422025-e07f8081b9c9.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347576/seed/photo-1493666438817-866a91353ca9.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347489/seed/screen-shot-2018-09-05-at-5-27-46-pm-e1536186712841.png",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347401/seed/woman.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347355/seed/_95182277_jesprofile3.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347211/seed/_6cfb1a60-a9ed-11e8-abd2-5c322fa89f61.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347055/seed/hanan-1.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537347006/seed/lilliya-scarlett-instagram-1528814125-custom-0.png",
          "https://res.cloudinary.com/dfcsmghw4/image/upload/v1537346964/seed/Teenager-dies-after-rolling-onto-broken-iPhone-cable-in-her-sleep.jpg"]
birth_dates = rand(18..40).to_s


emails.each_with_index do |x, i|
  puts "Creating #{first_names[i]} ..."
  User.create!(email: x,
               password: password,
               first_name: first_names[i],
               last_name: last_names[i],
               phone: phone,
               sentences: sentences[i]
               address: addresses[i],
               role: role,
               birth_date: "10/05/1995",
               photo: open(photos[i]))
  print "> #{first_names[i]} created !"
end

User.create!(email: "sarah4.b@gmail.com",
             password: "LVa123456" ,
             first_name: "sara",
             last_name: "harad",
             phone: "0987654321",
             address: "10 rue Pierre et Marie Curie, 33130 Bègles",
             role: 1,
             birth_date: "234567",
             photo: open("https://res.cloudinary.com/dfcsmghw4/image/upload/v1537346964/seed/Teenager-dies-after-rolling-onto-broken-iPhone-cable-in-her-sleep.jpg"))
