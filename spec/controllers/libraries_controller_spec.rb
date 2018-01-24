require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action' do 
      library = FactoryGirl.create(:library)
      get :show , id: library.id, format: 'json'
      response.should have_http_status(:ok)
    end 
    it 'should not be a valid Show Action' do 
      library = FactoryGirl.create(:library)
      get :show, id:'' , format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Show Action' do 
      library = FactoryGirl.create(:library)
      get :show, id:Faker::Company.name, format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action' do 
      library = FactoryGirl.create(:library)
      get :new , format:'json'
      response.should have_http_status(:ok) 
    end
    it'should be a valid Index Action' do 
      libraries = Library.all
      get :index , format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Edit Action' do 
      library = FactoryGirl.create(:library)
      get :edit , id:library.id , format:'json'
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Edit Action' do 
      library = FactoryGirl.create(:library)
      get :edit, id:Faker::Company.name , format:'json', library:{ name:'', address:'',phone:'' }
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should not be a valid Edit Action' do 
      library = FactoryGirl.create(:library)
      get :edit, id:'', format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do 
    it 'should be a valid Create Action' do
      post :create, format:'json', library:{ name:Faker::Company.name, address:Faker::Address.street_address, phone:Faker::Number.number(10)}
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Create Action' do 
      post :create, format:'json', library:{ name:'', address:'', phone:''}
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do 
    it 'should be a valid Update Action' do 
      library = FactoryGirl.create(:library)
      put :update, format:'json', id:library.id, library:{ name:library.name, address:library.address, phone:library.phone}
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Update Action' do 
      library = FactoryGirl.create(:library)
      put :update, format:'json', id:library.id, library:{ name:'', address:'', phone:'' }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Update Action' do 
      library = FactoryGirl.create(:library)
      put :update, format:'json', id:'', library:{ name:'', address:'', phone:'' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do 
    it 'should be a valid Destroy Action' do 
      library = FactoryGirl.create(:library)
      delete :destroy, format:'json', id:library.id 
      response.should have_http_status(:ok)
    end  
    it 'should not be a valid Destroy Action' do 
      library = FactoryGirl.create(:library)
      delete :destroy, format:'json', id:Faker::Company.name
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should be a valid Destroy Action' do 
      library = FactoryGirl.create(:library)
      delete :destroy, format:'json', id:''
      response.should have_http_status(:unprocessable_entity)
    end 
  end
end