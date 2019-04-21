class Location < ApplicationRecord
  validates :book_id, :presence => true
  validates :tune_id, :presence => true
  validates :page, :presence => true

  belongs_to(:book)
  belongs_to(:tune)
end
