# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource 
  skip_load_resource only: [:create] 

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout 'administrador'

  def listado
    datos = []
    User.all.each do |j| 
      datos << j.email 
    end

    render :json => datos.to_json
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @user = User.new
    @current_method = "new"
  end

	def show
    @evaluaciones = @user.evaluaciones.paginate(:page => params[:page], :per_page => 20)

   #@expedientes = Expediente.where("user_id = #{@user.id}").paginate(:page => params[:page], :per_page => 20)
	end

  def edit
  end

  def create
    @user = User.new(user_params)

#    params[:user][:role_ids].each do |r| 
#      @user.roles << Role.find(r)
#    end

    respond_to do |format|
      if @user.save
         format.html { redirect_to users_url, notice: t('mio.create_user') }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
#    params[:user][:role_ids].each do |r| 
#      @user.roles << Role.find(r)
#    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: t('mio.update_user') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, :notice => t('mio.destroy_user') }
        format.json { head :no_content }
      end
    rescue ActiveRecord::DeleteRestrictionError => e
      @user.errors.add(:base, "No se puede borrar este registro porque tiene dependencias en otras tablas.")
      render action: 'show'
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit!
#    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
