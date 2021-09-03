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
  end
end
