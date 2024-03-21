class Project::CreateProjectService
  def initialize(project_params, current_user)
    @project_params = project_params
    @current_user = current_user
  end

  def call
    create_project
  end

  private

  attr_reader :project_params, :current_user

  def create_project
    project = current_user.created_projects.build(project_params.except(:user_ids))

    if project.save
      add_users_to_project(project) if project_params[:user_ids].present?
      { status: :success, project: project }
    else
      { status: :error, project: project }
    end
  end

  def add_users_to_project(project)
    user_ids = project_params[:user_ids].split(',')
    user_ids.each do |user_id|
      unless ProjectAssignment.exists?(user_id: user_id, project_id: project.id)
        project.project_assignments.create(user_id: user_id.to_i)
      end
    end
  end
end
