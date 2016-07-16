Admin.create!(
  name: "Admin",
  email: "admin@railstutorial.org",
  password: "12345678",
  password_confirmation: "12345678",
  chatwork_id: "11111111111111111111")

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "12345678"
  chatwork_id = "11111111111111111111"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    chatwork_id: chatwork_id)
end

5.times do
  name = Faker::Name.title
  content = Faker::Lorem.sentence
  subject = Subject.create! content: content, number_of_questions: 20,
    duration: 30
end

users = User.all.order(:created_at)
users.each do |user|
  10.times do
    exams = user.exams.create!(
      status: rand(3),
      spent_time: 22,
      subject_id: rand(Subject.count) +1,
      score: 23)
  end
end
