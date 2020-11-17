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
  describe 'タスク一覧機能' do
    context '事前準備検証' do
      it 'ログイン後マイページからタスク一覧画面の検証' do
        expect(page).to have_content 'name : ユーザー1'
        expect(page).to have_content 'email : user1@hoge.jp'
        expect(page).to have_link 'プロフィールを編集'
      end
      it 'ログイン後マイページからタスク一覧画面の検証' do
        click_link 'タスク一覧'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク3'
        expect(task[0]).to have_content 'ラベル3'
        expect(task[1]).to have_content 'デフォルト2'
        expect(task[1]).to have_content 'ラベル2'
        expect(task[2]).to have_content 'デフォルトタスク1'
        expect(task[2]).to have_content 'ラベル1'
      end
    end
    context '検索条件検証(ラベル名を含む)' do
      before do
        click_link 'タスク一覧'
      end
      it '検索条件(タスク名 & ステータス & ラベル名)' do
        fill_in 'search_task_name', with: 'デフォルト'
        select '着手中', from: 'search_status'
        select 'ラベル2', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルト2'
        expect(task[0]).to have_content 'ラベル2'
      end
      it '検索条件(タスク名 & ラベル名)' do
        fill_in 'search_task_name', with: 'デフォルト'
        select 'ラベル3', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク3'
        expect(task[0]).to have_content 'ラベル3'
      end
      it '検索条件(ステータス & ラベル名)' do
        select '未着手', from: 'search_status'
        select 'ラベル1', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク1'
        expect(task[0]).to have_content 'ラベル1'
      end
      it '検索条件(ラベル名)' do
        select 'ラベル2', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルト2'
        expect(task[0]).to have_content 'ラベル2'
      end
    end
    context '検索条件検証(ラベル名を含まない)' do
      before do
        click_link 'タスク一覧'
      end
      it '検索条件(タスク名 & ステータス)' do
        fill_in 'search_task_name', with: 'デフォルト'
        select '完了', from: 'search_status'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク3'
        expect(task[0]).to have_content 'ラベル3'
      end
      it '検索条件(タスク名)' do
        fill_in 'search_task_name', with: 'デフォルトタスク'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク1'
        expect(task[0]).to have_content 'ラベル1'
        expect(task[1]).to have_content 'デフォルトタスク3'
        expect(task[1]).to have_content 'ラベル3'
      end
      it '検索条件(ステータス)' do
        select '未着手', from: 'search_status'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク1'
        expect(task[0]).to have_content 'ラベル1'
      end
    end
  end
  describe 'タスク作成機能' do
    before do
      click_link 'タスク一覧'
    end
    context 'タスク新規作成時' do
      it 'ラベルを追加(ラベル2)できる' do
        click_link '新規登録'
        expect(page).to have_content 'タスク登録'
        fill_in 'task_name', with: '追加タスク1'
        fill_in 'task_detail', with: 'タスク詳細1'
        fill_in 'task_dead_line', with: '002020-11-01'
        select '着手中', from: 'task[status]'
        select '中', from: 'task_priority'
        check 'ラベル2'
        # check 'ラベル2', from: 'task_label_ids_2'
        click_on '登録する'
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content '追加タスク1'
        expect(page).to have_content 'ラベル2'
      end
    end
  end
  describe 'タスク編集機能' do
    before do
      click_link 'タスク一覧'
    end
    context 'タスク編集時' do
      it 'ラベルを変更(ラベル1→ラベル3)できる' do
        task = Task.find_by(name: 'デフォルトタスク1')
        expect(page).to have_link '詳細', href: task_path(task)
        click_link '詳細', href: task_path(task)
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content 'デフォルトタスク1'
        expect(page).to have_content 'ラベル1'
        click_link '編集'
        uncheck 'ラベル2'
        check 'ラベル3'
        click_button '更新'
        task = Task.find_by(name: 'デフォルトタスク1')
        expect(page).to have_link '詳細', href: task_path(task)
        click_link '詳細', href: task_path(task)
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content 'デフォルトタスク1'
        expect(page).to have_content 'ラベル3'
      end
    end
  end
end
