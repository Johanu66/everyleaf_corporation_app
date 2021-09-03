FactoryBot.define do
  factory :task do
    name { 'Title 1 made by Factory' }
    detail { 'Default content created by Factory 1' }
  end
  factory :second_task, class: Task do
    name { 'Title 2 made by Factory' }
    detail { 'Default content 2 made by Factory' }
  end
end
