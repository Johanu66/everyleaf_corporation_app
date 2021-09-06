FactoryBot.define do
  factory :task do
    name { 'Title 1 made by Factory' }
    detail { 'Default content created by Factory 1' }
    expired_at { Time.now }
    status { 'Non demarré' }
    priority { "Moyenne" }
  end
  factory :second_task, class: Task do
    name { 'Title 2 made by Factory' }
    detail { 'Default content 2 made by Factory' }
    expired_at { Time.now }
    status { 'Non demarré' }
    priority { "Moyenne" }
  end
  factory :third_task, class: Task do
    name { 'Title 2 made by Factory' }
    detail { 'Default content 3 made by Factory' }
    expired_at { Time.now }
    status { 'Non demarré' }
    priority { "Moyenne" }
  end
end
