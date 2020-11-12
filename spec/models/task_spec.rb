require 'rails_helper'

describe 'タスクモデル機能', type: :model do
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
