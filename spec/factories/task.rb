FactoryBot.define do
  factory :task_case1, class: Task do
    name { 'デフォルトタスク1' }
    detail { 'デフォルトタスク詳細1' }
    dead_line { '2020/11/3' }
    status { '未着手' }
  end
  factory :task_case2, class: Task do
    name { 'デフォルト2' }
    detail { 'デフォルト詳細2' }
    dead_line { '2020/11/2' }
    status { '着手中' }
  end
  factory :task_case3, class: Task do
    name { 'デフォルトタスク3' }
    detail { 'デフォルトタスク詳細3' }
    dead_line { '2020/11/1' }
    status { '完了' }
  end
end
