User.create!(name: "Roberto Luis Rodriguez",
  email: "robertorodriguezjr86@gmail.com",
  password:              "starwars77",
  password_confirmation: "starwars77",
  admin: true)

  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
  end
