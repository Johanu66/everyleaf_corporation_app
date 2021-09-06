require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
    before do
        FactoryBot.create(:task, name: "task")
        FactoryBot.create(:second_task, name: "sample", priority: "Elevée")
        FactoryBot.create(:third_task, name: "sample1", status: "En cours")
    end
    describe 'New creation function' do
        context 'When creating a new task' do
            it 'The created task is displayed' do
                visit tasks_path
                expect(page).to have_content 'task'
            end
        end
        context 'When tasks are arranged in descending order of creation date and time' do
            it 'New task is displayed at the top' do
                visit tasks_path
                first_task_name = all('.names').first
                expect(first_task_name).to have_content 'sample'
            end
        end
        context 'When tasks are arranged in descending order of expered date and time' do
            it 'New task is displayed at the top' do
                visit tasks_path(sort_expired: "true")
                first_task_name = all('.names').first
                expect(first_task_name).to have_content 'sample'
            end
        end
        context 'When tasks are arranged in descending order of priority' do
            it 'New task is displayed at the top' do
                visit tasks_path(sort_priority: "true")
                first_task_name = all('.names').first
                expect(first_task_name).to have_content 'sample'
            end
        end
    end
    describe 'Search function' do
        context 'If you do a fuzzy search on the title' do
            it "Filtered by tasks containing the search keyword" do
              visit tasks_path
              find('#task_name').set('sample')
              find('#submit').click
              expect(page).to have_content 'sample'
            end
        end
        context 'If you do a status search' do
            it "Tasks that match the status exactly will be narrowed down." do
                visit tasks_path
                find('#task_status').set('En cours')
                find('#submit').click
                expect(page).to have_content 'En cours'
            end
        end
        context 'If you do a title fuzzy search and a status search' do
            it "Tasks that contain the search term in the title and match the status exactly will be narrowed down." do
                visit tasks_path
                find('#task_name').set('sample')
                find('#task_status').set('En cours')
                find('#submit').click
                expect(page).to have_content 'sample1'
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