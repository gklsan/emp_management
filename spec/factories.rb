FactoryBot.define do
  factory :company do
    name Faker::Name.name
    contact '4324342333'
    license_number 'TEWER43243'
    started_at Time.now
    founder_name 'Founder one'
    address 'USA'
  end

  factory :department do
    name Faker::Company.name
    description Faker::Company.catch_phrase
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(" test #{name}") }
    password { '123456' }
    company { FactoryBot.create(:company) }
    department { FactoryBot.create(:department) }
    phone Faker::Number.number(10).to_s
    salary Faker::Number.number(5)
    bonus Faker::Number.number(3)
  end
end
