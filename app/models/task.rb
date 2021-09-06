class Task < ApplicationRecord
    enum priority: ['Faible', 'Moyenne', 'Elevée']

    validates :name, presence: true
    validates :expired_at, presence: true
    validates :detail, presence: true

    scope :search_by_name, -> (name){Task.all.where("name LIKE ?", "%#{name}%")}
    scope :search_by_status, -> (status){Task.all.where(status: status)}
    scope :search_by_name_and_status, -> (name,status){Task.all.where("name LIKE ?", "%#{name}%").where(status: status)}
end
