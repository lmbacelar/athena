class Category < ActiveRecord::Base
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :acronym, presence: true, uniqueness: true
  validates :level, presence: true, inclusion: 1..12

  # Associations
  has_many :documents, dependent: :destroy
end
