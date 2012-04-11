class Version < ActiveRecord::Base
  # Validations
  validates :number, presence: true, uniqueness: { scope: :document_id }
  validates :author, presence: true
  validates :document, presence: true
  validates :authored_date, presence: true
  validates :authored_date, date: { before_or_equal_to: Proc.new { Time.zone.now } }
  validates :checked_date, date: { after_or_equal_to: :authored_date, allow_nil: true }
  validates :approved_date, date: { after_or_equal_to: :checked_date, allow_nil: true }
  validates :withdrawn_date, date: { after_or_equal_to: :authored_date, allow_nil: true }

  # Associations
  belongs_to :document, touch: true

  # Methods
  def state
    if withdrawn_date
      :withdrawn
    elsif approved_date
      :approved
    elsif checked_date
      :checked
    else
      :draft
    end
  end
end
