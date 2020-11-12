require 'rails_helper'

describe 'タスクモデルバリデーション機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに抵触' do
        task = Task.new(name: '', detail: '失敗テスト', dead_line: '2020/11/1', status: '未着手')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションに抵触' do
        task = Task.new(name: '失敗テスト', detail: '', dead_line: '2020/11/1', status: '着手中')
        expect(task).not_to be_valid
      end
    end
    context '終了期限が空の場合' do
      it 'バリデーションに抵触' do
        task = Task.new(name: '失敗テスト', detail: 'テスト成功', dead_line: '', status: '未着手')
        expect(task).not_to be_valid
      end
    end
    context 'ステータスが空の場合' do
      it 'バリデーションに抵触' do
        task = Task.new(name: 'テスト成功', detail: 'テスト成功', dead_line: '2020/11/1', status: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細、終了期限に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: 'テスト成功', detail: 'テスト成功', dead_line: '2020/11/1', status: '着手中')
        expect(task).to be_valid
      end
    end
  end
end
describe 'タスクモデルスコープ機能', type: :model do
  before do
    @case1 = FactoryBot.create(:task_case1)
    @case2 = FactoryBot.create(:task_case2)
    @case3 = FactoryBot.create(:task_case3)
  end
  describe '検索機能' do
    # let!(:first_task) = FactoryBot.create(:first_task, name: "task1", status: "未着手") }
    # let!(:second_task) = FactoryBot.create(:first_task,name: "taks2", status: "着手中") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.name_like('タスク')).to include(@case1)
        expect(Task.name_like('タスク')).to include(@case3)
        expect(Task.name_like('タスク')).not_to include(@case2)
        expect(Task.name_like('タスク').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_is('着手中')).to include(@case2)
        expect(Task.status_is('着手中')).not_to include(@case1)
        expect(Task.status_is('着手中')).not_to include(@case3)
        expect(Task.status_is('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_like('タスク').status_is('完了')).to include(@case3)
        expect(Task.name_like('タスク').status_is('完了')).not_to include(@case1)
        expect(Task.name_like('タスク').status_is('完了')).not_to include(@case2)
      end
    end
  end
end
