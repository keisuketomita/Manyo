require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task_case1)
    FactoryBot.create(:task_case2)
    FactoryBot.create(:task_case3)
  end
  describe '一覧表示機能' do
    context '終了期限をクリックした場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        within first('thead tr') do
          click_link '終了期限'
        end
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク1'
        expect(task[1]).to have_content 'デフォルト2'
        expect(task[2]).to have_content 'デフォルトタスク3'
      end
    end
  end
end
