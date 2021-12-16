require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, title: 'task',status:'完了', user_id: @user.id)
    @second_task = FactoryBot.create(:second_task, title: 'task2',status:'完了', user_id: @user.id)
  end
  describe '検索機能' do
    # @task = user.tasks.build(title: 'task',status:'完了',)
    # @second_task = user.tasks.build(title: 'sample',status:'完了',)
    # let!(:task) { FactoryBot.create(:task, title: 'task',status:'完了') }
    # let!(:second_task) { FactoryBot.create(:second_task, title: "sample",status:'完了') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意
        expect(Task.search_title('task2')).not_to include(@task)
        expect(Task.search_title('task2')).to include(@second_task)
        expect(Task.search_title('task2').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('完了')).to include(@task)
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('task')).to include(@task)
        expect(Task.search_status('完了')).to include(@task)
      end
    end
  end

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user, email: 'a1@example.com', id: 300)
        task = user.tasks.build(title: '通過テスト', content: '通過テスト',status:'未着手',
                        deadline: '2100-12-31',priority:0)
        expect(task).to be_valid
      end
    end
  end
end
