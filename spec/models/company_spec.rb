require 'rails_helper'

RSpec.describe Company, type: :model do
  context '#create' do
    it 'without any argument' do
      company = Company.create
      errors = company.errors.full_messages
      expect(errors).to include("Name can't be blank")
      expect(errors).to include("Contact can't be blank")
      expect(errors).to include("License number can't be blank")
      expect(errors).to include("Founder name can't be blank")
      expect(errors).to include("Started at can't be blank")
    end

    it 'with argument' do
      company = Company.create(name: 'Company one',
                               contact: '4324342333',
                               license_number: 'TEWER43243',
                               started_at: Time.now,
                               founder_name: 'Founder one',
                               address: 'USA')
      expect(company.valid?).to eq(true)
      expect(company.name).to eq('Company one')
    end
  end
end
