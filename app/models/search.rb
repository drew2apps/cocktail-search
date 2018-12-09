class Search < ApplicationRecord
  has_and_belongs_to_many :recipes
  validates_uniqueness_of :query
  validates :query, presence: true
end