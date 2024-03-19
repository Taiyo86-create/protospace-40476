class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :edit]

  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
    @prototype = Prototype.find_by(id: params[:id])
    @comment = Comment.new
  end


  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in?
      redirect_to action: :index, status: :unprocessable_entity
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to action: :show
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
