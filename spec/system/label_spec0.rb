require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    user = FactoryBot.create(:user_case1)
    @task4 = FactoryBot.create(:task_case4, user: user)
    @task5 = FactoryBot.create(:task_case5, user: user)
    @task6 = FactoryBot.create(:task_case6, user: user)
    @task7 = FactoryBot.create(:task_case7, user: user)
    @task8 = FactoryBot.create(:task_case8, user: user)
    @task9 = FactoryBot.create(:task_case9, user: user)
    @label1 = FactoryBot.create(:label_case1)
    @label2 = FactoryBot.create(:label_case2)
    @label3 = FactoryBot.create(:label_case3)
    FactoryBot.create(:labelling, task: @task4, label: @label1)
    FactoryBot.create(:labelling, task: @task5, label: @label2)
    FactoryBot.create(:labelling, task: @task6, label: @label3)
    FactoryBot.create(:labelling, task: @task7, label: @label2)
    FactoryBot.create(:labelling, task: @task8, label: @label2)
    FactoryBot.create(:labelling, task: @task9, label: @label3)
    visit root_path
    fill_in 'eMail_session', with: 'user1@hoge.jp'
    fill_in 'password_session', with: 'hogehoge'
    click_button 'ログイン'
    # save_and_open_page
  end
  describe 'タスク一覧機能' do
    context '検索条件検証(ラベル名を含む)' do
      before do
        click_link 'タスク一覧'
      end
      it '検索条件(タスク名 & ステータス & ラベル名)' do
        fill_in 'search_task_name', with: 'デフォルト'
        select '未着手', from: 'search_status'
        select 'ラベル1', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク4'
        expect(task[0]).to have_content '未着手'
        expect(task[0]).to have_content 'ラベル1'
      end
      it '検索条件(タスク名 & ラベル名)' do
        fill_in 'search_task_name', with: 'デフォルト'
        select 'ラベル1', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク4'
        expect(task[0]).to have_content '未着手'
        expect(task[0]).to have_content 'ラベル1'
      end
      it '検索条件(ステータス & ラベル名)' do
        select '完了', from: 'search_status'
        select 'ラベル2', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク8'
        expect(task[0]).to have_content '完了'
        expect(task[0]).to have_content 'ラベル2'
      end
      it '検索条件(ラベル名)' do
        select 'ラベル3', from: 'search_label'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク6'
        expect(task[0]).to have_content '完了'
        expect(task[0]).to have_content 'ラベル3'
        expect(task[1]).to have_content 'デフォルトタクス9'
        expect(task[1]).to have_content '未着手'
        expect(task[1]).to have_content 'ラベル3'
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
        expect(task[0]).to have_content 'デフォルトタスク6'
        expect(task[0]).to have_content '完了'
        expect(task[0]).to have_content 'ラベル3'
        expect(task[1]).to have_content 'デフォルトタスク8'
        expect(task[1]).to have_content '完了'
        expect(task[1]).to have_content 'ラベル2'
      end
      it '検索条件(タスク名)' do
        fill_in 'search_task_name', with: 'タクス'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタクス9'
        expect(task[0]).to have_content '未着手'
        expect(task[0]).to have_content 'ラベル3'
      end
      it '検索条件(ステータス)' do
        select '着手中', from: 'search_status'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトタスク5'
        expect(task[0]).to have_content '着手中'
        expect(task[0]).to have_content 'ラベル2'
      end
    end
  end
end
