require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  describe 'ラベル機能' do
    before do
      @user = FactoryBot.create(:user)
      @label = FactoryBot.create(:label)
    end
    context 'ラベルをつけてタスクを作成時' do
      it 'ラベルがタスク一覧に表示される' do
        visit new_session_path
        fill_in 'Email', with: 'test1@email.com'
        fill_in 'Password', with: 'test123'
        click_button 'Log in'
        visit new_task_path
        fill_in 'Title', with: 'test'
        fill_in 'Content', with: 'test'
        fill_in'task[deadline]', with: '002020-10-06'
        check '仕事'
        click_button '登録する'
        visit tasks_path
        expect(page).to have_content '仕事'
      end
    end
    context 'ラベルを複数登録した時' do
      it '複数ラベルがタスク一覧に表示される' do
        visit new_session_path
        fill_in 'Email', with: 'test1@email.com'
        fill_in 'Password', with: 'test123'
        click_button 'Log in'
        visit new_task_path
        fill_in 'Title', with: 'test'
        fill_in 'Content', with: 'test'
        fill_in'task[deadline]', with: '002020-10-06'
        check '仕事'
        check '家族'
        click_button '登録する'
        visit tasks_path
        expect(page).to have_content '仕事' '家族'
      end
    end
    context 'ラベルを編集した時' do
      it 'ラベルが変更される' do
        visit new_session_path
        fill_in 'Email', with: 'test1@email.com'
        fill_in 'Password', with: 'test123'
        click_button 'Log in'
        visit new_task_path
        fill_in 'Title', with: 'test'
        fill_in 'Content', with: 'test'
        fill_in'task[deadline]', with: '002020-10-06'
        check '仕事'
        check '家族'
        click_button '登録する'
        visit tasks_path
        click_on 'Edit'
        check '会食'
        check '友人'
        click_button '更新する'
        visit tasks_path
        expect(page).to have_content '会食' '友人'
      end
    end
    context 'ラベルを検索した時' do
      it '選んだラベルのタスク一覧が表示される' do
        visit new_session_path
        fill_in 'Email', with: 'test1@email.com'
        fill_in 'Password', with: 'test123'
        click_button 'Log in'
        visit new_task_path
        fill_in 'Title', with: 'test'
        fill_in 'Content', with: 'test'
        fill_in'task[deadline]', with: '002020-10-06'
        check '仕事'
        check '家族'
        click_button '登録する'
        visit new_task_path
        fill_in 'Title', with: 'test'
        fill_in 'Content', with: 'test'
        fill_in'task[deadline]', with: '002020-10-06'
        check '会食'
        check '友人'
        click_button '登録する'
        visit tasks_path
        select '会食', from: 'label_id'
        click_button 'Search'
        expect(page).to have_content '会食'
      end
    end
  end
end
