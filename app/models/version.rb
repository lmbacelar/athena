class Version < ActiveRecord::Base
  # Validations
  validates :number, presence: true, uniqueness: { scope: :document_id }
  validates :author, presence: true
  validates :document, presence: true
  validates :authored_date, presence: true
  validates :authored_date, date: { before_or_equal_to: Proc.new { Time.zone.now } }

  # Associations
  belongs_to :document, touch: true

  # Methods
end
