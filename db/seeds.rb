Admin.create!(
  name: "Admin",
  email: "admin@railstutorial.org",
  password: "12345678",
  password_confirmation: "12345678",
  chatword_id: "11111111111111111111")

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "12345678"
  chatword_id = "11111111111111111111"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    chatword_id: chatword_id)
end
