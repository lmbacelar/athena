class Document < ActiveRecord::Base
  validates :name,  presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
end
