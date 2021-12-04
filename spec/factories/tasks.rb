FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    deadline {'2020-10-01'}
    status {'未着手'}
    priority {'高'}
  end
  factory :second_task, class:Task do
    title { 'test_title2' }
    content { 'test_content2' }
    deadline {'2020-11-01'}
    status {'着手中'}
    priority {'低'}
  end
  factory :third_task, class:Task do
    title { 'test_title3' }
    content { 'test_content3' }
    deadline {'2020-12-01'}
    status {'完了'}
      priority {'中'}
  end
end
