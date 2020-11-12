require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task_case1)
    FactoryBot.create(:task_case2)
    FactoryBot.create(:task_case3)
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        # task = FactoryBot.create(:task, name: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'デフォルトタスク1'
        expect(page).to have_content 'デフォルトタスク詳細1'
        expect(page).to have_content 'デフォルトタスク2'
        expect(page).to have_content 'デフォルトタスク詳細2'
        expect(page).to have_content 'デフォルトタスク3'
        expect(page).to have_content 'デフォルトタスク詳細3'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '追加したタスクが最初の行に表示される' do
        visit tasks_path
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク詳細3'
        expect(task[1]).to have_content 'デフォルトタスク詳細2'
        expect(task[2]).to have_content 'デフォルトタスク詳細1'
      end
    end
    context '終了期限をクリックした場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        within first('thead tr') do
          click_link '終了期限'
        end
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク詳細1'
        expect(task[1]).to have_content 'デフォルトタスク詳細2'
        expect(task[2]).to have_content 'デフォルトタスク詳細3'
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
         task = Task.find_by(name: 'デフォルトタスク2')
         # クリックしたいリンク（詳細）が含まれていることを確認
         expect(page).to have_link '詳細', href: task_path(task)
         # 該当の詳細リンクをクリック
         click_link '詳細', href: task_path(task)
         # タスク詳細ページの表示を確認する
         expect(page).to have_content 'デフォルトタスク2'
         expect(page).to have_content 'デフォルトタスク詳細2'
       end
     end
  end
end
