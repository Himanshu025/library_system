require 'rails_helper'

RSpec.describe IssueHistoriesController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      get :show , id: issue_history.id, format: 'json'
      response.should have_http_status(:ok)
    end 
    it 'should not be a valid Show Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      get :show, id:'' , format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Show Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      get :show, id:'bnabnban', format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      get :new , format:'json'
      response.should have_http_status(:ok) 
    end
    it'should be a valid Index Action' do 
      issue_histories = IssueHistory.all
      get :index , format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Edit Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      get :edit , id:issue_history.id , format:'json'
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Edit Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      get :edit, id: 'acas' , format:'json', issue_history:{ issue_type:'', issue_date:'', return_date:'', member_id:'', book_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should not be a valid Edit Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      get :edit, id:'', format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do 
    it 'should be a valid Create Action' do
      member = FactoryGirl.create(:member)
      book = FactoryGirl.create(:book)
      post :create, format:'json', issue_history:{ issue_type:'rent', issue_date:'2017-08-13', return_date:'2017-09-13', member_id:member.id, book_id:book.id }
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Create Action' do 
      post :create, format:'json', issue_history:{ issue_type:'', issue_date:'', return_date:'', member_id:'', book_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do 
    it 'should be a valid Update Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      put :update, format:'json', id:issue_history.id, issue_history:{ issue_type:issue_history.issue_type, issue_date:issue_history.issue_date, return_date:issue_history.return_date, member_id:issue_history.member_id, book_id:issue_history.book_id }
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Update Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      put :update, format:'json', id:issue_history.id, issue_history:{ issue_type:'', issue_date:'', return_date:'', member_id:'', book_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Update Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      put :update, format:'json', id:'', issue_history:{ issue_type:'', issue_date:'', return_date:'', member_id:'', book_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do 
    it 'should be a valid Destroy Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      delete :destroy, format:'json', id:issue_history.id 
      response.should have_http_status(:ok)
    end  
    it 'should not be a valid Destroy Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      delete :destroy, format:'json', id:'hahjahka'
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should be a valid Destroy Action' do 
      issue_history = FactoryGirl.create(:issue_history)
      delete :destroy, format:'json', id:''
      response.should have_http_status(:unprocessable_entity)
    end 
  end
end