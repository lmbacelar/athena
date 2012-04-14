class Document < ActiveRecord::Base
  # Validations
  validates :name,  presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  # Associations
  belongs_to :category
  has_many :versions, dependent: :destroy

  # # # # # Public Methods
  # # # # # Instance Methods
  def to_s
    name
  end
end
