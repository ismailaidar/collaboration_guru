class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :project_assignments
  has_many :projects, through: :project_assignments
  has_many :events
  # projects that the user has created
  has_many :created_projects, class_name: 'Project', foreign_key: 'user_id'

  enum role: {
    admin: 'admin',
    project_manager: 'project_manager',
    team_member: 'team_member'
  }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= 'team_member'
  end
end
