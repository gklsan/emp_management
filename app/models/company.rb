class Company < ApplicationRecord
  resourcify
  has_paper_trail
  has_many :users

  validates :name, :license_number, :founder_name, :started_at, presence: true
  validates :contact, presence: true, length: { is: 10 }
end
