require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
    before do
        # Create two tasks to use in the task list test in advance
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
    end
    describe 'New creation function' do
        context 'When creating a new task' do
            it 'The created task is displayed' do
                # undefinedで使用するためのタスクを作成
                task = FactoryBot.create(:task, name: 'task')
                # Transition to task list page
                visit tasks_path
                # The text "task" appears on the visited (transitioned) page (task list page)
                # expect (confirm/expect) that have_content is included (is included)
                expect(page).to have_content 'task'
                # expectの結果が true ならundefined成功、false なら失敗として結果が出力される
            end
        end
    end
    describe 'List display function' do
        context 'When transitioning to the list screen' do
            it 'The created task list is displayed' do
            end
        end
    end
    describe 'Detailed display function' do
        context 'When transitioned to any task details screen' do
            it 'The content of the relevant task is displayed' do
            end
        end
    end
end