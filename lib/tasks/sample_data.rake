namespace :db do
   desc "Full database with sample data"
   task populate: :environment do
      User.create!(name: "Vitaly Ostapenko",
                 email: "ostapenko.vitaly@gmail.com",
                 password: "vitaly",
                 password_confirmation: "vitaly",
                 locale: "ru")
      admin = User.create!(name: "Site Administrator",
                  email: "admin@gmail.com",
                  password: "administrator",
                  password_confirmation: "administrator",
                  locale: "en")
      admin.toggle!(:admin)
      99.times do |n|
        name = Faker::Name.name
        email = "example-#{n+1}@railstutorial.org"
        password = "password"
        User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password,
                    locale: "en")
      end
   end
end
