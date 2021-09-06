require 'rails_helper'
RSpec.describe Task, type: :model do
  describe 'Task model function', type: :model do
    describe 'Validation test' do
      context 'If the task Title is empty' do
        it 'It\'s hard to Validation' do
          task = Task.new(name: '', detail: 'Failure test')
          expect(task).not_to be_valid
        end
      end
      context 'If the task details are empty' do
        it 'Validation is caught' do
          task = Task.new(name: 'Failure test', detail: '')
          expect(task).not_to be_valid
        end
      end
      context 'If the task Title and details are described' do
        it 'Validation passes' do
        end
      end
    end
    
    describe 'Search function' do
      let!(:task) { FactoryBot.create(:task, name: 'task') }
      let!(:second_task) { FactoryBot.create(:second_task, name: "sample") }
      let!(:third_task) { FactoryBot.create(:third_task, name: "sample1", status: "En cours") }
      context 'If you use the scope method to perform a fuzzy title search' do
        it "Tasks containing the search keyword will be narrowed down." do
          expect(Task.search_by_name('task')).to include(task)
          expect(Task.search_by_name('task')).not_to include(second_task)
          expect(Task.search_by_name('task').count).to eq 1
        end
      end
      context 'If you do a status search with the scope method' do
        it "Tasks that match the status exactly will be narrowed down." do
          expect(Task.search_by_status('En cours')).to include(third_task)
          expect(Task.search_by_status('En cours')).not_to include(second_task)
          expect(Task.search_by_status('En cours').count).to eq 1
        end
      end
      context 'If you use the scope method to perform a title fuzzy search and a status search' do
        it "Tasks that contain the search term in the title and match the status exactly will be narrowed down." do
          expect(Task.search_by_name_and_status('sample','En cours')).to include(third_task)
          expect(Task.search_by_name_and_status('sample','En cours')).not_to include(second_task)
          expect(Task.search_by_name_and_status('sample','En cours').count).to eq 1
        end
      end
    end
  end
end
