class Book < ApplicationRecord
  strip_attributes :collapse_spaces => true

  validates :title, :presence => true, :uniqueness => true, :case_sensitive => false
  validates :offset, :presence => true

  has_many :locations, :dependent => :destroy
  has_many :tunes, :through => :locations
end
