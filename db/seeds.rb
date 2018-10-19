User.where.not(email: "abriko@yahoo.fr").destroy_all
Trip.destroy_all

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
cities = ["Bordeaux", "Bordeaux", "Bordeaux", "Le Haillan", "Mérignac", "Bordeaux", "Bordeaux", "Bordeaux"]
sentences = ["J'aime le yoga et la cuisine",
              "J'aime l'art et la danse",
              "J'aime voyager et faire des rencontres",
              "J'aimes les éléphants bleus et les chats loufoques",
              "J'aime rire entre amis",
              "J'aime me dire qu'il est bon de changer",
              "Je serai votre meilleur hôte à Bordeaux",
              "J'adore les sushis et les films de ninja",
              "J'aime voir le monde et ses couleurs"]
photos = ["https://res.cloudinary.com/dfcsmghw4/image/private/s--ZCdIf1Ex--/v1537430205/seed/csrcm4ulusejyngjdzhn.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s--23Jzortx--/v1537430206/seed/ylhs5obe9bgts6bft4gl.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s--vgs7jyN7--/v1537430208/seed/xf0gn4fvwr18f1oyqtfg.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s--JGrNKbnx--/v1537430209/seed/e9uk2gmry3yo3wt00ggx.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s--PEVNC-cD--/v1537430211/seed/kub6ozsw9ycrktmyov3c.png",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s--H8FC5tZV--/v1537430212/seed/hp9dcodxaecttocu3fso.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s---au51Qjz--/v1537430213/seed/vgfklhwblyyt5lqm83rt.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s--5NQ5mEFZ--/v1537430215/seed/rjmrbr7a6hrfafwsjsyq.jpg",
          "https://res.cloudinary.com/dfcsmghw4/image/private/s--yS2F3HeI--/v1537430216/seed/rmscx1xilaysbhbm4dts.jpg"]
birth_dates = rand(18..40).to_s


emails.each_with_index do |x, i|
  print "Creating #{first_names[i]} ..."
  User.create!(email: x,
               password: password,
               first_name: first_names[i],
               last_name: last_names[i],
               phone: phone,
               sentence: sentences[i],
               address: addresses[i],
               city: cities[i],
               role: rand(1..2),
               host: rand(0..2),
               birth_date: "10/05/1995",
               photo: open(photos[i]))

  puts "> #{first_names[i]} created !"
end

@users = User.where.not(email: "abriko@yahoo.fr")
dates = ["01/04/2019", "13/12/2018","01/11/2018","22/10/2018","16/12/20018","21/11/2018","22/01/2019","01/01/2019","02/02/2019","05/05/2019"]


puts "Creating trips"
print "["
10.times do |index|
  user = host = User.find(rand(@users.first.id..@users.last.id))
  while host == user
    host = User.find(rand(@users.first.id..@users.last.id))
  end
  Trip.create!(traveller:user, host: host, beginning: dates[index], end: dates[index+1] || dates[0])
  print "-"
end
puts ["]"]
puts "Trips created"

# User.create!(email: "sarah7.b@gmail.com",
#              password: "LVa123456" ,
#              first_name: "sara",
#              last_name: "harad",
#              phone: "0987654321",
#              address: "10 rue Pierre et Marie Curie, 33130 Bègles",
#              role: 1,
#              birth_date: "234567",
#              sentence: "Hey it's me",
#              photo: open("https://res.cloudinary.com/dfcsmghw4/image/upload/v1537346964/seed/Teenager-dies-after-rolling-onto-broken-iPhone-cable-in-her-sleep.jpg"))
