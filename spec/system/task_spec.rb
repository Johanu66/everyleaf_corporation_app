require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
    let!(:task) { FactoryBot.create(:task, name: 'task') }
    before do
        visit tasks_path
    end
    describe 'New creation function' do
        context 'When creating a new task' do
            it 'The created task is displayed' do
                expect(page).to have_content 'task'
            end
        end
        context 'When tasks are arranged in descending order of creation date and time' do
            it 'New task is displayed at the top' do
              first_task_name = all('.names').first
              expect(first_task_name).to have_content 'task'
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