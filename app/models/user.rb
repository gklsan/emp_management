class User < ApplicationRecord
  rolify
  attr_accessor :role_type
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  belongs_to :department

  def has_admin_role?
    roles_name.include?('admin')
  end

end
