class ChefsController < ApplicationController
 
  def index
    #@chefs = Chef.all
    @chefs = Chef.paginate(page: params[:page],per_page: 5)
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "welcome #{@chef.chefname} to MyRecipes app!"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.paginate(page:params[:page], per_page: 5)#phantrang
  end

  def edit
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "your account was updated successfully"
      redirect_to @chef
    else
        render 'edit'
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmiation)
  end
end