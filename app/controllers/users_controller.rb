class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_is_admin?, only: [:index, :destroy]

  # GET /users
  # GET /users.json
  def index
    @admins = User.with_role(:admin, current_user.company).preload(:roles)
    @employees = User.with_role(:employee, current_user.company).preload(:roles)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params.merge({password: '123456'}))
    respond_to do |format|
      if @user.save
        @user.add_role(user_params[:role_type], current_user.company)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, notice: @user.errors.full_messages }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        current_role = @user.roles_name.first
        if current_role != user_params[:role_type]
          @user.remove_role(current_role.to_sym, current_user.company)
          @user.add_role(user_params[:role_type].to_sym, current_user.company)
        end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :address, :salary, :bonus, :role_type, :department_id, :company_id)
    end

    def verify_is_admin?
      has_admin_role = current_user.has_role?(:admin, current_user.company)
      redirect_to current_user and return unless has_admin_role
    end
end
