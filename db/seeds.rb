puts "Seeding started #{'*' * 10}"

Department.destroy_all
User.destroy_all
Company.destroy_all
PaperTrail::Version.destroy_all
Role.destroy_all

require 'date'

def create_department
  Department.create!(name: 'Sales', description: 'Department of Sales')
  Department.create!(name: 'Marketing', description: 'Department of Marketing')
  Department.create!(name: 'Production', description: 'Department of Production')
end

def create_company
  datetime = DateTime.now
  Company.create!(name: 'Company 1', license_number: 'ABCD12345', started_at: datetime, founder_name: 'Founder ABCD', contact: '9123232132', address: 'USA')
  Company.create!(name: 'Company 2', license_number: 'XYZE54543', started_at: datetime, founder_name: 'Founder XYZE', contact: '9563442345', address: 'USA')
end


def create_user(type, i)
  email = "#{type}+#{i}@#{type}.#{type}"
  return if User.find_by(email: email)
  company = Company.all.sample
  user ||= User.create!(name: "#{type} #{i}".humanize,
                        email: email,
                        password: '123456',
                        phone: "445435233#{i}",
                        address: "USA - #{i}",
                        salary: rand(19452) * i,
                        bonus: rand(4342) * i,
                        company: company,
                        department: Department.all.sample
  )
  role = user.has_role?(type.to_sym, company)
  puts "Create: #{type}----- #{user.name} "
  user.add_role(type.to_sym, company) unless role
  puts user.roles.pluck(:name)
end


create_department unless Department.first
create_company unless Company.first
unless User.first
  5.times do |i|
    create_user('admin', i + 1)
  end

  20.times do |i|
    create_user('employee', i + 1 )
  end
end

puts "Seeding completed #{'*' * 10}"