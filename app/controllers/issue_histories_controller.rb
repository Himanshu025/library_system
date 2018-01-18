class IssueHistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @issue_histories = IssueHistory.all
    respond_to do |format|
      format.json { render json: { issue_histories: @issue_histories }, status: :ok }
      format.html
    end
  end

  def new
    @issue_history = IssueHistory.new
    respond_to do |format|
      format.json { render json: { issue_history: @issue_history},status: :ok }
      format.html
    end
  end

  def edit
    begin
      @issue_history = IssueHistory.find(params[:id])
      respond_to do |format|
        format.json { render json: { issue_history: @issue_history},status: :ok }
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
    @issue_history = IssueHistory.create(issue_history_params)
    if @issue_history.save
      respond_to do |format|
        format.json { render json: { issue_history: @issue_history }, status: :ok }
        format.html  
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Issue_History Not Added' }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def show
    begin
      @issue_history = IssueHistory.find(params[:id])
      @issue_history
      respond_to do |format|
        format.json { render json: { issue_history: @issue_history }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @issue_history = IssueHistory.find(params[:id])
    if @issue_history.update_attributes(issue_history_params)
      respond_to do |format|
        format.json { render json: { issue_history: @issue_history }, status: :ok }
        format.html 
      end
    else
      respond_to do |format|
        format.json { render json: { message: @issue_history.errors }, status: :unprocessable_entity }
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
      @issue_history = IssueHistory.find(params[:id])
      @issue_history.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html 
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def issue_history_params
    params.require(:issue_history).permit(:issue_type, :issue_date, :return_date, :member_id, :book_id )
  end
end
