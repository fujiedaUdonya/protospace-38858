class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:show,:edit]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.includes(:user)
  end
    
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototypes_params)
    if @prototype.save
      redirect_to root_path
    else
      render :nwe
    end  
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end
  
  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototypes_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end  

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
  end
    
  private

  def prototypes_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
end  
