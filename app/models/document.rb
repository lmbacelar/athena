class Document < ActiveRecord::Base
  # Validations
  validates :name,  presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true

  # Associations
  has_many :versions, dependent: :destroy

end
