class QueryLog < ApplicationRecord
  validates :ip, :presence => true
  validates :query, :presence => true
end
