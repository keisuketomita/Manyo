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
  factory :task_case4, class: Task do
    name { 'デフォルトタスク4' }
    detail { 'デフォルトタスク詳細4' }
    dead_line { '002020-11-01' }
    status { '未着手' }
    priority { 1 }
    association :user
  end
  factory :task_case5, class: Task do
    name { 'デフォルトタスク5' }
    detail { 'デフォルトタスク詳細5' }
    dead_line { '002020-11-01' }
    status { '着手中' }
    priority { 1 }
    association :user
  end
  factory :task_case6, class: Task do
    name { 'デフォルトタスク6' }
    detail { 'デフォルトタスク詳細6' }
    dead_line { '002020-11-01' }
    status { '完了' }
    priority { 1 }
    association :user
  end
  factory :task_case7, class: Task do
    name { 'デフォルトタスク7' }
    detail { 'デフォルトタスク詳細7' }
    dead_line { '002020-11-01' }
    status { '未着手' }
    priority { 1 }
    association :user
  end
  factory :task_case8, class: Task do
    name { 'デフォルトタスク8' }
    detail { 'デフォルトタスク詳細8' }
    dead_line { '002020-11-01' }
    status { '完了' }
    priority { 1 }
    association :user
  end
  factory :task_case9, class: Task do
    name { 'デフォルトタクス9' }
    detail { 'デフォルトタスク詳細9' }
    dead_line { '002020-11-01' }
    status { '未着手' }
    priority { 1 }
    association :user
  end
end
