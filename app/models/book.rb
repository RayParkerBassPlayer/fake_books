class Book < ApplicationRecord
  strip_attributes :collapse_spaces => true

  validates :title, :presence => true, :uniqueness => true, :case_sensitive => false

  has_many :locations
  has_many :tunes, :through => :locations
end
