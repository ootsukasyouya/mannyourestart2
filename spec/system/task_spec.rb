require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '検索機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', password:'password', password_confirmation:'password')
      @task1 = FactoryBot.create(:task, title: 'test_title',user: user_a)
      @task2 = FactoryBot.create(:second_task, title: 'test_title2',user: user_a)
      @task3 = FactoryBot.create(:third_task, title: 'test_title3',status: '完了',user: user_a)
      visit new_session_path
      fill_in 'Email', with: 'a@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end
    context 'タイトルであいまい検索した場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'test_title2'
        click_on '検索'
        expect(page).to have_content 'test_title2'
      end
    end
    context 'ステータスを検索した場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "完了", from:"status"
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'test_title3'
        select "完了", from:"status"
        click_on '検索'
        expect(page).to have_content 'test_title3'
        expect(page).to have_content '完了'
      end
    end
    context 'タスクを新規作成した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content('test_title',count:Task.count)
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.tr_list')
        expect(task_list[0]).to have_content 'test_title3'
        expect(task_list[1]).to have_content 'test_title2'
        expect(task_list[2]).to have_content 'test_title'
      end
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
          visit task_path(@task1.id)
          expect(page).to have_content 'test_title'
      end
    end
    context '終了期限でソートした場合' do
      it '新しい日付が１番上に表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        sleep 1.0
        task_list = all('.tr_list')
        expect(task_list[0]).to have_content '2020-12-01'
        expect(task_list[1]).to have_content '2020-11-01'
        expect(task_list[2]).to have_content '2020-10-01'
      end
    end
    context '優先順位でソートした場合' do
      it "高いものから順に表示される" do
        visit tasks_path
        click_on '優先順位でソートする'
        sleep 1.0
        task_list = all('.tr_list')
        expect(task_list[0]).to have_content '0'
        expect(task_list[1]).to have_content '2'
        expect(task_list[2]).to have_content '1'
      end
    end
  end
end
