class Recipe < ApplicationRecord
  has_and_belongs_to_many :searches
end
