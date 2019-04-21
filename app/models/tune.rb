class Tune < ApplicationRecord
  strip_attributes :collapse_spaces => true

  validates :title, :presence => true, :uniqueness => true, :case_sensitive => false

  has_many :locations
  has_many :books, :through => :locations

  def self.add_tune!(title:, page: nil, book: nil)
    valid_location?(page, book)

    tune = Tune.find_or_create_by(:title => title)

    if page.present?
      book = get_book(book)
      tune.locations << Location.find_or_create_by(:tune => tune, :page => page, :book => book)
    end

    tune
  end

  def add_location!(page:, book:)
    valid_location?(page, book)

    book = Tune.get_book(book)

    self.locations << Location.find_or_create_by(:page => page, :book => book)
  end

  private 

  def self.valid_location?(page, book)
    if (page.nil? && book.present?) || (page.present? && book.nil?)
      raise ArgumentError.new("Page AND Book both have to be supplied.")
    end

    true
  end

  def valid_location?(page, book)
    Tune.valid_location?(page, book)
  end

  def self.get_book(book)
    if book.is_a?(Integer)
      Book.find(book)
    elsif book.is_a?(Book)
      return book
    else
      Book.find_or_create_by(:title => book)
    end
  end
end
