require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action' do 
      member = FactoryGirl.create(:member)
      get :show , id: member.id, format: 'json'
      response.should have_http_status(:ok)
    end 
    it 'should not be a valid Show Action' do 
      member = FactoryGirl.create(:member)
      get :show, id:'' , format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Show Action' do 
      member = FactoryGirl.create(:member)
      get :show, id:Faker::Company.name, format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action' do 
      member = FactoryGirl.create(:member)
      get :new , format:'json'
      response.should have_http_status(:ok) 
    end
    it'should be a valid Index Action' do 
      members = Member.all
      get :index , format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Edit Action' do 
      member = FactoryGirl.create(:member)
      get :edit , id:member.id , format:'json'
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Edit Action' do 
      member = FactoryGirl.create(:member)
      get :edit, id:Faker::Company.name , format:'json', member:{ name:'', phone:'', address:'', gender:'', validity_date:'', code:'', is_author:'', library_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should not be a valid Edit Action' do 
      member = FactoryGirl.create(:member)
      get :edit, id:'', format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do 
    it 'should be a valid Create Action' do
      library = FactoryGirl.create(:library)
      post :create, format:'json', member:{ name: Faker::Name.name_with_middle, phone: Faker::Number.number(10), address: Faker::Address.street_address, gender: Faker::Boolean.boolean(1), validity_date: Faker::Date.between(2.days.ago, Date.today).strftime("%F"), code: Faker::Number.number(4), is_author: Faker::Boolean.boolean(1), library_id: library.id }
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Create Action' do 
      post :create, format:'json', member:{ name:'', phone:'', address:'', gender:'', validity_date:'', code:'', is_author:'', library_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do 
    it 'should be a valid Update Action' do 
      member = FactoryGirl.create(:member)
      put :update, format:'json', id:member.id, member:{ name: member.name, phone: member.phone, address: member.address, gender: member.gender, validity_date: member.validity_date, code: member.code, is_author: member.is_author, library_id: member.library_id }
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Update Action' do 
      member = FactoryGirl.create(:member)
      put :update, format:'json', id:member.id, member:{ name:'', phone: '', address:'', gender:'', validity_date:'', code:'', is_author:'', library_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Update Action' do 
      member = FactoryGirl.create(:member)
      put :update, format:'json', id:'', member:{ name:'', phone: '', address:'', gender:'', validity_date:'', code:'', is_author:'', library_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do 
    it 'should be a valid Destroy Action' do 
      member = FactoryGirl.create(:member)
      delete :destroy, format:'json', id:member.id 
      response.should have_http_status(:ok)
    end  
    it 'should not be a valid Destroy Action' do 
      member = FactoryGirl.create(:member)
      delete :destroy, format:'json', id:Faker::Name.name
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should be a valid Destroy Action' do 
      member = FactoryGirl.create(:member)
      delete :destroy, format:'json', id:''
      response.should have_http_status(:unprocessable_entity)
    end 
  end
end