class MembersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @members = Member.all
    respond_to do |format|
      format.json { render json: { members: @members }, status: :ok }
      format.html
    end
  end

  def new
    @member = Member.new
    respond_to do |format|
      format.json { render json: { member: @member},status: :ok }
      format.html
    end
  end

  def edit
    begin
      @member = Member.find(params[:id])
      respond_to do |format|
        format.json { render json: { member: @member},status: :ok }
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
    @member = Member.create(member_params)
    if @member.save
      respond_to do |format|
        format.json { render json: { member: @member }, status: :ok }
        format.html  
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Member Not Added' }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def show
    begin
      @member = Member.find(params[:id])
      respond_to do |format|
        format.json { render json: { member: @member }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      respond_to do |format|
        format.json { render json: { member: @member }, status: :ok }
        format.html 
      end
    else
      respond_to do |format|
        format.json { render json: { message: @member.errors }, status: :unprocessable_entity }
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
      @member = Member.find(params[:id])
      @member.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html 
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :phone, :address, :gender, :validity_date, :code, :is_author, :library_id)
  end
end
