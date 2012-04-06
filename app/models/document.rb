class Document < ActiveRecord::Base
  NameLengthRange = 1..25
  validates :name,  presence: true, uniqueness: true, length: { in: NameLengthRange }
  validates :title, presence: true, uniqueness: true
end
