require 'rails_helper'

def error_messages
  ["Email can't be blank",
   'Email is invalid',
   "Password can't be blank",
   'Company must exist',
   'Department must exist',
   "Name can't be blank",
   "Salary can't be blank",
   "Bonus can't be blank",
   "Phone can't be blank",
   'Phone is the wrong length (should be 10 characters)']
end

RSpec.describe User, type: :model do
  context '#create' do
    it 'without any argument' do
      user = User.create
      expect(user.valid?).to eq(false)
      errors = user.errors.full_messages
      error_messages.each do |error|
        expect(errors).to include(error)
      end
    end
  end
end
