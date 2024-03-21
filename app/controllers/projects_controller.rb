class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show; end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        if project_params[:user_ids].present?
          user_ids = project_params['user_ids'].split(',')
          user_ids.each do |user_id|
            @project.project_assignments.create(user_id: user_id.to_i)
          end
        end
        format.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    return unless @project.destroy

    respond_to do |format|
      # Removes the target from the dom. The target can either be a dom id string or an object that responds to to_key (ruby/turbo docs)
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove("project_#{@project.id}"),
          turbo_stream.update('flash_messages', partial: 'partials/notification',
                                                locals: { flash: { notice: 'Project has been deleted successfully!' } })
        ]
      end
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date, :status, :user_ids)
  end
end
