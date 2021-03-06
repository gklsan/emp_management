class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :verify_is_admin?, except: [:show]

  # GET /companies
  # GET /companies.json
  def index
    @company = current_users_company
    @users = User.includes(:roles).where(company: @company).order('roles.name, users.id')
    @reports = User.find_by_sql(top_salary_report_sql)
    @versions = PaperTrail::Version.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show; end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find_by_id(params[:id]) || current_users_company
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :license_number, :started_at, :founder_name, :contact, :address)
  end

  def verify_is_admin?
    has_admin_role = current_user.has_role?(:admin, current_users_company)
    redirect_to(current_user) && return unless has_admin_role
  end

  def top_salary_report_sql
    sql = %( SELECT u1.name uname, d.name dname, salary, department_id FROM users u1
              INNER JOIN departments as d
              ON u1.department_id = d.Id
              WHERE 3 > (
                SELECT COUNT(DISTINCT Salary)
                FROM users u2
                WHERE u2.salary > u1.salary
                AND u1.department_id = u2.department_id
                AND u2.company_id = #{current_users_company.id}
              ) and company_id = #{current_users_company.id}
              ORDER BY d.name ASC, Salary DESC;
          )
  end
end
