require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    user = FactoryBot.create(:user_case1)
    FactoryBot.create(:task_case1, user: user)
    FactoryBot.create(:task_case2, user: user)
    FactoryBot.create(:task_case3, user: user)
    visit root_path
    fill_in 'eMail_session', with: 'user1@hoge.jp'
    fill_in 'password_session', with: 'hogehoge'
    click_button 'ログイン'
  end
  # save_and_open_page
  describe '一覧表示機能' do
    context '終了期限をクリックした場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        sleep 1.0
        first('thead tr').click_link '終了期限'
        sleep 1.0
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク1'
        expect(task[1]).to have_content 'デフォルト2'
        expect(task[2]).to have_content 'デフォルトタスク3'
      end
    end
    context '優先順位をクリックした場合' do
      it '優先順位の高い順で表示される' do
        visit tasks_path
        sleep 1.0
        first('thead tr').click_link '優先順位'
        sleep 1.0
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク3'
        expect(task[1]).to have_content 'デフォルト2'
        expect(task[2]).to have_content 'デフォルトタスク1'
      end
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'デフォルトタスク1'
        expect(page).to have_content 'デフォルト2'
        expect(page).to have_content 'デフォルトタスク3'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '追加したタスクが最初の行に表示される' do
        visit tasks_path
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク3'
        expect(task[1]).to have_content 'デフォルト2'
        expect(task[2]).to have_content 'デフォルトタスク1'
      end
    end
    context 'タスク名とステータスで検索した場合' do
      it '両方の検索結果が反映されたタスクが表示される' do
        # label_spec.rb で検証しているため、削除
        # it '検索条件(タスク名 & ステータス)'
      end
    end
    context 'タスク名のみで検索した場合' do
      it 'タスク名の検索結果が反映されたタスクが表示される' do
        # label_spec.rb で検証しているため、削除
        # it '検索条件(タスク名)'
      end
    end
    context 'ステータスのみで検索した場合' do
      it 'ステータスの検索結果が反映されたタスクが表示される' do
        # label_spec.rb で検証しているため、削除
        # it '検索条件(ステータス)'
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'task_name', with: 'タスク1'
      fill_in 'task_detail', with: 'タスク詳細1'
      fill_in 'task_dead_line', with: '002020-11-01'
      select '着手中', from: 'task[status]'
      select '中', from: 'task_priority'
      click_on '登録する'
      expect(page).to have_content 'タスク1'
    end
  end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit tasks_path
         task = Task.find_by(name: 'デフォルト2')
         expect(page).to have_link '詳細', href: task_path(task)
         click_link '詳細', href: task_path(task)
         expect(page).to have_content 'デフォルト2'
       end
     end
  end
end
