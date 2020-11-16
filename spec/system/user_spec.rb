require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    @user1 = FactoryBot.create(:user_case1)
    @user2 = FactoryBot.create(:user_case2)
    @user3 = FactoryBot.create(:user_case3)
  end
  # save_and_open_page
  describe 'ユーザー登録のテスト' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーのマイページが表示される' do
        visit new_user_path
        fill_in 'uID', with: 'ユーザー'
        fill_in 'eMail', with: 'user@hoge.jp'
        fill_in 'password', with: 'hogehoge'
        fill_in 'password_confirmation', with: 'hogehoge'
        click_button 'アカウント作成'
        expect(page).to have_content 'ユーザー'
        expect(page).to have_content 'user@hoge.jp'
        expect(page).to have_link 'プロフィールを編集'
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ログイン時の操作検証' do
      it 'ログインせずにタスク一覧に入ろうとした場合ログイン画面が表示される' do
        visit new_session_path
        expect(page).to have_button 'ログイン'
      end
      it 'ログインができる' do
        visit new_session_path
        fill_in 'eMail_session', with: 'user1@hoge.jp'
        fill_in 'password_session', with: 'hogehoge'
        click_button 'ログイン'
        expect(page).to have_content 'ユーザー1'
        expect(page).to have_content 'user1@hoge.jp'
        expect(page).to have_link 'プロフィールを編集'
      end
    end
    context 'ログイン後の操作検証' do
      before do
        visit new_session_path
        fill_in 'eMail_session', with: 'user1@hoge.jp'
        fill_in 'password_session', with: 'hogehoge'
        click_button 'ログイン'
      end
      it 'ログイン後マイページが表示される' do
        expect(page).to have_content 'ユーザー1'
        expect(page).to have_content 'user1@hoge.jp'
        expect(page).to have_link 'プロフィールを編集'
      end
      it '他人の詳細画面にアクセスすると参照できずタスク一覧が表示される' do
        visit user_path(@user2)
        expect(page).to have_content '他人のプロフィールを閲覧・編集することはできません'
      end
      it 'ログアウトができる' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理画面へのアクセス' do
      it '管理ユーザーはアクセスできる' do
        visit new_session_path
        fill_in 'eMail_session', with: 'admin@hoge.jp'
        fill_in 'password_session', with: 'hogehoge'
        click_button 'ログイン'
        expect(page).to have_content 'ユーザー管理画面'
      end
      it '一般ユーザーはアクセスできない' do
        visit new_session_path
        fill_in 'eMail_session', with: 'user1@hoge.jp'
        fill_in 'password_session', with: 'hogehoge'
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_content 'あなたには管理者権限がありません'
      end
    end
    context '管理ユーザーの各種操作(CRUD)' do
      before do
        visit new_session_path
        fill_in 'eMail_session', with: 'admin@hoge.jp'
        fill_in 'password_session', with: 'hogehoge'
        click_button 'ログイン'
      end
      it 'ユーザーの新規登録ができる' do
        click_link '新規登録'
        fill_in 'uID_admin', with: 'ユーザー'
        fill_in 'eMail_admin', with: 'user@hoge.jp'
        fill_in 'password_admin', with: 'hogehoge'
        fill_in 'password_confirmation_admin', with: 'hogehoge'
        click_button 'アカウント作成'
        expect(page).to have_content 'ユーザー管理画面'
        expect(page).to have_content 'ユーザー'
        expect(page).to have_content 'user@hoge.jp'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        user = User.find_by(name: 'ユーザー1')
        expect(page).to have_link '詳細', href: admin_user_path(user)
        click_link '詳細', href: admin_user_path(user)
        expect(page).to have_content 'ユーザー1'
        expect(page).to have_content 'user1@hoge.jp'
        expect(page).to have_link 'プロフィールを編集'
      end
      it 'ユーザーの編集画面から編集できる' do
        user = User.find_by(name: 'ユーザー2')
        expect(page).to have_link '編集', href: edit_admin_user_path(user)
        click_link '編集', href: edit_admin_user_path(user)
        fill_in 'uID_admin_edit', with: 'ユーザー22'
        fill_in 'eMail_admin_edit', with: 'user22@hoge.jp'
        click_button 'プロフィールを変更'
        expect(page).to have_content 'ユーザーを編集しました'
        expect(page).to have_content 'ユーザー22'
        expect(page).to have_content 'user22@hoge.jp'
      end
      it 'ユーザーの一覧画面から削除できる' do
        user = User.find_by(name: 'ユーザー1')
        expect(page).to have_link '削除', href: admin_user_path(user)
        page.accept_confirm do
          click_link '削除', href: admin_user_path(user)
        end
        expect(page).to have_content 'ユーザーを削除しました'
        expect(page).not_to have_content 'ユーザー1'
        expect(page).not_to have_content 'user1@hoge.jp'
      end
    end
  end
end
