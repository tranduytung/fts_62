Admin.create!(
  name: "Admin",
  email: "admin@railstutorial.org",
  password: "12345678",
  password_confirmation: "12345678",
  chatwork_id: "11111111111111111111")

10.times do |n|
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

subject = Subject.all
subject.each do |subject|
  50.times do
    question = subject.questions.build(
      content: Faker::Lorem.sentence,
      question_type: 0,
      status: 1)
    question.answers = [
      Answer.new(content: Faker::Lorem.characters(5), is_correct: true),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false)
    ].shuffle
    question.save!
  end
end

users = User.all.order(:created_at)
users.each do |user|
  2.times do
    exams = user.exams.create!(
      status: rand(2),
      spent_time: 22,
      subject_id: rand(Subject.count) +1)
  end
end

exams = Exam.all.where(status: 1)
exams = exams.take(exams.count)
exams.each do |exam|
  exam.results.each do |result|
    answer = result.question.answers.last
    result.update answer: answer, is_correct: answer.is_correct
  end
  exam.update status: 2
end
