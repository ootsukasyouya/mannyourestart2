# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Label.create!([
  { name: '仕事' },
  { name: '私用' },
  { name: '会食' },
  { name: '実家' },
  { name: '家族' },
  { name: '子供' },
  { name: '運動' },
  { name: '資格' },
  { name: 'テスト' },
  { name: '料理' },
  { name: 'ペット' }
])
User.create!(
   email: 'te@test.com',
   name: 'テスト太郎',
   name: 'admin',
   password: '123456',
   admin: true
)
10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "test_user#{n + 1}",
    password: '12345',
  )
end
10.times do |m|
  10.times do |n|
    Task.create!(
      title:"test_task#{n+1}",
      content:"test#{n+1}",
    )
  end
end
