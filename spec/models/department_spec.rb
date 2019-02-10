require 'rails_helper'

RSpec.describe Department, type: :model do
  context '#create' do
    it 'without any argument' do
      dept = Department.create
      errors = dept.errors.full_messages
      expect(dept.valid?).to eq(false)
      expect(errors).to include("Name can't be blank")
    end

    it 'with argument' do
      dept = Department.create(name: 'Company one',
                               description: 'company one description')
      expect(dept.valid?).to eq(true)
      expect(dept.name).to eq('Company one')
    end
  end
end
