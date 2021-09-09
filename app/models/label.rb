class Label < ApplicationRecord
    has_many :task_labels
    validates :name, presence: true
end
