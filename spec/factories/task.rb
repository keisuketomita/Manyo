FactoryBot.define do
  factory :task_case1, class: Task do
    name { 'デフォルトタスク1' }
    detail { 'デフォルトタスク詳細1' }
    dead_line { '2020/11/3' }
  end
  factory :task_case2, class: Task do
    name { 'デフォルトタスク2' }
    detail { 'デフォルトタスク詳細2' }
    dead_line { '2020/11/2' }
  end
  factory :task_case3, class: Task do
    name { 'デフォルトタスク3' }
    detail { 'デフォルトタスク詳細3' }
    dead_line { '2020/11/1' }
  end
end
