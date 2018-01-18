class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @books = Book.all
    respond_to do |format|
      format.json { render json: { books: @books }, status: :ok }
      format.html
    end
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.json { render json: { book: @book},status: :ok }
      format.html
    end
  end

  def edit
    begin
      @book = Book.find(params[:id])
      respond_to do |format|
        format.json { render json: { book: @book},status: :ok }
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
    @book = Book.create(book_params)
    if @book.save
      respond_to do |format|
        format.json { render json: { book: @book }, status: :ok }
        format.html  
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Book Not Added' }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def show
    begin
      @book = Book.find(params[:id])
      respond_to do |format|
        format.json { render json: { book: @book }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      respond_to do |format|
        format.json { render json: { book: @book }, status: :ok }
        format.html 
      end
    else
      respond_to do |format|
        format.json { render json: { message: @book.errors }, status: :unprocessable_entity }
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
      @book = Book.find(params[:id])
      @book.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html 
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :isbn, :price, :publication, :version, :no_of_copies, :library_id, :category_id)
  end
end
