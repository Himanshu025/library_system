class LibrariesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @libraries = Library.all
    respond_to do |format|
      format.json { render json: { libraries: @libraries }, status: :ok }
      format.html
    end
  end

  def new
    @library = Library.new
    respond_to do |format|
      format.json { render json: { library: @library},status: :ok }
      format.html
    end
  end

  def edit
    begin
      @library = Library.find(params[:id])
      respond_to do |format|
        format.json { render json: { library: @library},status: :ok }
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
    @library = Library.create(library_params)
    if @library.save
      respond_to do |format|
        format.json { render json: { library: @library }, status: :ok }
        format.html  
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Library Not Added' }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def show
    begin
      @library = Library.find(params[:id])
      respond_to do |format|
        format.json { render json: { library: @library }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @library = Library.find(params[:id])
    if @library.update_attributes(library_params)
      respond_to do |format|
        format.json { render json: { library: @library }, status: :ok }
        format.html 
      end
    else
      respond_to do |format|
        format.json { render json: { message: @library.errors }, status: :unprocessable_entity }
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
      @library = Library.find(params[:id])
      @library.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html 
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def library_params
    params.require(:library).permit(:name, :address, :phone)
  end
end
