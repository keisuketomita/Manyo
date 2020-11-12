require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task_case1)
    FactoryBot.create(:task_case2)
    FactoryBot.create(:task_case3)
  end
  describe '一覧表示機能' do
    context '優先順位をクリックした場合' do
      it '優先順位の高い順で表示される' do
        visit tasks_path
        within first('thead tr') do
          click_link '優先順位'
        end
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク3'
        expect(task[1]).to have_content 'デフォルト2'
        expect(task[2]).to have_content 'デフォルトタスク1'
      end
    end
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
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'デフォルトタスク1'
        expect(page).to have_content 'デフォルトタスク詳細1'
        expect(page).to have_content 'デフォルト2'
        expect(page).to have_content 'デフォルト詳細2'
        expect(page).to have_content 'デフォルトタスク3'
        expect(page).to have_content 'デフォルトタスク詳細3'
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
        visit tasks_path
        fill_in 'search_task_name', with: 'デフォルト'
        find("#status").find("option[value='着手中']").select_option
        click_on 'Search'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルト詳細2'
      end
    end
    context 'タスク名のみで検索した場合' do
      it 'タスク名の検索結果が反映されたタスクが表示される' do
        visit tasks_path
        fill_in 'search_task_name', with: 'タスク'
        find("#status").find("option[value='']").select_option
        click_on 'Search'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク詳細1'
        expect(task[1]).to have_content 'デフォルトタスク詳細3'
      end
    end
    context 'ステータスのみで検索した場合' do
      it 'ステータスの検索結果が反映されたタスクが表示される' do
        visit tasks_path
        find("#status").find("option[value='完了']").select_option
        click_on 'Search'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク詳細3'
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      # new_task_pathに遷移する（新規作成ページに遷移する）
      visit new_task_path
      # 新規登録内容を入力する
      fill_in 'task_name', with: 'タスク1'
      fill_in 'task_detail', with: 'タスク詳細1'
      fill_in 'task_dead_line', with: '002020-11-01'
      # 「登録する」というvalue（表記文字）のあるボタンをクリックする
      click_on '登録する'
      # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      expect(page).to have_content 'タスク1'
      expect(page).to have_content 'タスク詳細1'
    end
  end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         # タスク一覧ページに遷移
         visit tasks_path
         # クリックしたい行を特定
         task = Task.find_by(name: 'デフォルト2')
         # クリックしたいリンク（詳細）が含まれていることを確認
         expect(page).to have_link '詳細', href: task_path(task)
         # 該当の詳細リンクをクリック
         click_link '詳細', href: task_path(task)
         # タスク詳細ページの表示を確認する
         expect(page).to have_content 'デフォルト2'
         expect(page).to have_content 'デフォルト詳細2'
       end
     end
  end
end
