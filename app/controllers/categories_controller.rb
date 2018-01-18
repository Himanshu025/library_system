class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @categories = Category.all
    respond_to do |format|
      format.json { render json: { categories: @categories }, status: :ok }
      format.html
    end
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.json { render json: { category: @category},status: :ok }
      format.html
    end
  end

  def edit
    begin
      @category = Category.find(params[:id])
      respond_to do |format|
        format.json { render json: { category: @category},status: :ok }
        format.html
      end
    rescue Exception => e
      respond_to do |format|
        format.json { render json: { message: e.message }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      respond_to do |format|
        format.json { render json: { category: @category }, status: :ok }
        format.html  
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Category Not Added' }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def show
    begin
      @category = Category.find(params[:id])
      respond_to do |format|
        format.json { render json: { category: @category }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      respond_to do |format|
        format.json { render json: { category: @category }, status: :ok }
        format.html 
      end
    else
      respond_to do |format|
        format.json { render json: { message: @category.errors }, status: :unprocessable_entity }
        format.html 
      end
    end
  rescue Exception => e
    respond_to do |format|
      format.json { render json: { message: e.message }, status: :unprocessable_entity }
      format.html 
    end
  end

  def destroy
    begin
      @category = Category.find(params[:id])
      @category.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html 
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
