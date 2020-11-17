require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    before do
      @user = FactoryBot.create(:user_case1)
    end
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに抵触' do
        user = @user
        task = user.tasks.build(name: '', detail: '失敗テスト', dead_line: '2020/11/1', status: '未着手', priority: 1, user_id: 1)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションに抵触' do
        user = @user
        task = user.tasks.build(name: '失敗テスト', detail: '', dead_line: '2020/11/1', status: '着手中', priority: 1, user_id: 1)
        expect(task).not_to be_valid
      end
    end
    context '終了期限が空の場合' do
      it 'バリデーションに抵触' do
        user = @user
        task = user.tasks.build(name: '失敗テスト', detail: 'テスト成功', dead_line: '', status: '未着手', priority: 1, user_id: 1)
        expect(task).not_to be_valid
      end
    end
    context 'ステータスが空の場合' do
      it 'バリデーションに抵触' do
        user = @user
        task = user.tasks.build(name: 'テスト成功', detail: 'テスト成功', dead_line: '2020/11/1', status: '', priority: 1, user_id: 1)
        expect(task).not_to be_valid
      end
    end
    context '優先順位が空の場合' do
      it 'バリデーションに抵触' do
        user = @user
        task = user.tasks.build(name: 'テスト成功', detail: 'テスト成功', dead_line: '2020/11/1', status: '着手中', priority: '', user_id: 1)
        expect(task).not_to be_valid
      end
    end
    context '全ての項目が入力されている場合' do
      it 'バリデーションが通る' do
        user = @user
        task = user.tasks.build(name: 'テスト成功', detail: 'テスト成功', dead_line: '2020/11/1', status: '着手中', priority: 1, user_id: 1)
        expect(task).to be_valid
      end
    end
  end
  describe 'タスクモデルスコープ機能', type: :model do
    before do
      @user = FactoryBot.create(:user_case1)
      @case1 = FactoryBot.create(:task_case1, user: @user)
      @case2 = FactoryBot.create(:task_case2, user: @user)
      @case3 = FactoryBot.create(:task_case3, user: @user)
    end
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
        expect(Task.name_like('タスク').status_is('完了').count).to eq 1
      end
    end
  end
end
