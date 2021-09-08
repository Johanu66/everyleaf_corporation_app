class Task < ApplicationRecord
    belongs_to :user

    enum priority: ['Faible', 'Moyenne', 'Elevée']

    validates :name, presence: true
    validates :expired_at, presence: true
    validates :detail, presence: true

    scope :search_by_name, -> (name){current_user.tasks.where("name LIKE ?", "%#{name}%")}

    scope :search_by_status, -> (status){current_user.tasks.where(status: status)}
    
    scope :search_by_name_and_status, -> (name,status){current_user.tasks.where("name LIKE ?", "%#{name}%").where(status: status)}
end
