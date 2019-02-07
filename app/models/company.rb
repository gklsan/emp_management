class Company < ApplicationRecord
  resourcify
  has_paper_trail
  has_many :users
end
