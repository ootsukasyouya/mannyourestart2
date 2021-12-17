require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザを新規作成した場合' do
      it 'プロフィールを確認できる' do
        visit new_user_path
        fill_in 'Name', with: 'newuser'
        fill_in 'Email', with: 'new@gmail.com'
        fill_in 'Password', with: 'newuser'
        fill_in 'Password confirmation', with: 'newuser'
        click_button 'Create my account'
        expect(page).to have_content 'newuserのページ'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に飛ぶ' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
      @third_user = FactoryBot.create(:third_user)
    end
    context 'ユーザーがログインした場合' do
      it 'ログインができる' do
        visit new_session_path
        fill_in 'Email', with: 'test1@email.com'
        fill_in 'Password', with: 'test123'
        click_button 'Log in'
        expect(page).to have_content 'test1のページ'
      end
    end
    context 'ユーザーがログインした時' do
      it 'マイページに飛べる' do
        visit new_session_path
        fill_in 'Email', with: 'test1@email.com'
        fill_in 'Password', with: 'test123'
        click_button 'Log in'
        expect(current_path).to eq current_path
      end
    end
    context '一般ユーザが他人の詳細画面にいこうとすると'do
      it 'タスク一覧画面に遷移する' do
       visit new_session_path
       fill_in 'Email', with: 'test1@email.com'
       fill_in 'Password', with: 'test123'
       click_button 'Log in'
       visit user_path(@second_user)
       expect(current_path).to eq tasks_path
      end
    end
    context 'ユーザーがログアウトした時'do
      it 'ログイン画面に戻る'do
      visit new_session_path
      fill_in 'Email', with: 'test1@email.com'
      fill_in 'Password', with: 'test123'
      click_button 'Log in'
      click_on 'ログアウト'
      sleep(1)
      expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      @user = FactoryBot.create(:user)
      # @second_user = FactoryBot.create(:second_user)
      @third_user = FactoryBot.create(:third_user)
    end
    context '管理ユーザが管理画面にアクセスした時' do
      it '管理画面を表示' do
        visit new_session_path
        fill_in 'Email', with: 'admin_user@mail.com'
        fill_in 'Password', with: '9999999'
        click_button 'Log in'
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end
    context '一般ユーザが管理画面にアクセスした時' do
      it '権限がありません' do
        visit new_session_path
        fill_in 'Email', with: 'test1@email.com'
        fill_in 'Password', with: 'test123'
        click_button 'Log in'
        visit admin_users_path
        expect(page).to have_content '権限がありません'
      end
    end
    context '管理ユーザがユーザの新規登録を押した時' do
      it 'ユーザーが追加される' do
        visit new_session_path
        fill_in 'Email', with: 'admin_user@mail.com'
        fill_in 'Password', with: '9999999'
        click_button 'Log in'
        visit admin_users_path
        click_on '作成'
        fill_in 'Name', with: 'neo'
        fill_in 'Email', with: 'neo@gmail.com'
        fill_in 'Password', with: 'neouser'
        fill_in 'Password confirmation', with: 'neouser'
        click_button 'Create my account'
        expect(page).to have_content 'neo'
      end
    end
    context '管理者ユーザがユーザの詳細画面にアクセスした時' do
      it 'ユーザの詳細画面を表示' do
        visit new_session_path
        fill_in 'Email', with: 'admin_user@mail.com'
        fill_in 'Password', with: '9999999'
        click_button 'Log in'
        visit admin_users_path
        all('tbody tr')[1].click_link '詳細'
        click_on '詳細'
        expect(page).to have_content 'test1のページ'
      end
    end
    context '管理ユーザが編集画面で名前を変更した時' do
      it '一覧画面で名前が変更される' do
        visit new_session_path
        fill_in 'Email', with: 'admin_user@mail.com'
        fill_in 'Password', with: '9999999'
        click_button 'Log in'
        visit admin_users_path
        all('tbody tr')[0].click_link '編集'
        fill_in 'user_name', with: 'purupuru'
        click_button '送信する'
        expect(page).to have_content 'purupuru'
      end
    end
    context '管理者がユーザを削除した時' do
      it '一覧画面からユーザが削除される' do
        visit new_session_path
        fill_in 'Email', with: 'admin_user@mail.com'
        fill_in 'Password', with: '9999999'
        click_button 'Log in'
        visit admin_users_path
        all('tbody tr')[1].click_link '削除'
        expect(User.count).to eq 1
      end
    end
  end
end
