FactoryBot.define do
  factory :task_case1, class: Task do
    name { 'デフォルトタスク1' }
    detail { 'デフォルトタスク詳細1' }
    dead_line { '002020-11-03' }
    status { '未着手' }
    priority { 0 }
    association :user
  end
  factory :task_case2, class: Task do
    name { 'デフォルト2' }
    detail { 'デフォルト詳細2' }
    dead_line { '002020-11-02' }
    status { '着手中' }
    priority { 1 }
    association :user
  end
  factory :task_case3, class: Task do
    name { 'デフォルトタスク3' }
    detail { 'デフォルトタスク詳細3' }
    dead_line { '002020-11-01' }
    status { '完了' }
    priority { 2 }
    association :user
  end
end
