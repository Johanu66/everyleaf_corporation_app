class Task < ApplicationRecord
    belongs_to :user
    has_many :task_labels

    enum priority: ['Faible', 'Moyenne', 'Elevée']

    validates :name, presence: true
    validates :expired_at, presence: true
    validates :detail, presence: true

    scope :search_by_label, -> (label_id,current_user){
        current_user.tasks.where(id: TaskLabel.where(label_id: label_id).pluck(:task_id))
    }

    scope :search_by_name, -> (name,current_user){current_user.tasks.where("name LIKE ?", "%#{name}%")}

    scope :search_by_status, -> (status,current_user){current_user.tasks.where(status: status)}
    
    scope :search_by_name_and_status, -> (name,status,current_user){current_user.tasks.where("name LIKE ?", "%#{name}%").where(status: status)}
end
