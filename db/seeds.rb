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
# User.create!(
#    email: 'te@test.com',
#    name: 'テスト太郎',
#    name: 'admin',
#    password: '123456',
#    admin: true
# )
10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "test_user#{n + 1}",
    password: '123456',
  )
end
    Task.create!(
      user_id: User.find(1).id,
      title: "test1",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(2).id,
      title: "test2",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(3).id,
      title: "test3",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(4).id,
      title: "test4",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(5).id,
      title: "test5",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(6).id,
      title: "test6",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(7).id,
      title: "test7",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(8).id,
      title: "test8",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(9).id,
      title: "test9",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
    Task.create!(
      user_id: User.find(10).id,
      title: "test10",
      content: "test",
      deadline: "2020-12-01",
      status: 0,
      priority: 0
    )
