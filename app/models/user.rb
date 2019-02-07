class User < ApplicationRecord
  rolify
  has_paper_trail
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :role_type

  belongs_to :company
  belongs_to :department

  def has_admin_role?
    roles_name.include?('admin')
  end

  def role_name
    roles_name.first
  end

  def department_name
    department&.name
  end

  def company_name
    company&.name
  end

  def set_role(role_type, company)
    self.add_role(role_type.to_sym, company)
  end

  def remove_existing_role(role_type, company)
    self.remove_role(role_type.to_sym, company)
  end

end
