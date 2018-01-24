require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action' do 
      book = FactoryGirl.create(:book)
      get :show , id: book.id, format: 'json'
      response.should have_http_status(:ok)
    end 
    it 'should not be a valid Show Action' do 
      book = FactoryGirl.create(:book)
      get :show, id:'' , format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Show Action' do 
      book = FactoryGirl.create(:book)
      get :show, id:Faker::Name.name, format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action' do 
      book = FactoryGirl.create(:book)
      get :new , format:'json'
      response.should have_http_status(:ok) 
    end
    it'should be a valid Index Action' do 
      book = Book.all
      get :index , format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Edit Action' do 
      book = FactoryGirl.create(:book)
      get :edit , id:book.id , format:'json'
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Edit Action' do 
      book = FactoryGirl.create(:book)
      get :edit, id:'Faker::Book.title' , format:'json', book:{ name:'' }
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should not be a valid Edit Action' do 
      book = FactoryGirl.create(:book)
      get :edit, id:'', format:'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do 
    it 'should be a valid Create Action' do
      library = FactoryGirl.create(:library)
      category = FactoryGirl.create(:category)
      post :create, format:'json', book:{ name:Faker::Book.title , author:Faker::Book.author, isbn:Faker::Code.isbn, price:Faker::Number.decimal(3,2), publication:Faker::Book.publisher, version:Faker::Number.between(1, 10), no_of_copies: Faker::Number.between(1, 20), library_id:library.id, category_id:category.id }
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Create Action' do 
      post :create, format:'json', book:{ name:'', author:'', isbn:'', price:'', publication:'', version:'', no_of_copies:'', library_id:'', category_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do 
    it 'should be a valid Update Action' do 
      book = FactoryGirl.create(:book)
      put :update, format:'json', id:book.id, book:{ name:book.name , author:book.author, isbn:book.isbn, price:book.price, publication:book.publication, version:book.version, no_of_copies:book.no_of_copies, library_id:book.library_id, category_id:book.category_id }
      response.should have_http_status(:ok)
    end
    it 'should not be a valid Update Action' do 
      book = FactoryGirl.create(:book)
      put :update, format:'json', id:book.id, book:{ name:'', author:'', isbn:'', price:'', publication:'', version:'', no_of_copies:'', library_id:'', category_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should not be a valid Update Action' do 
      book = FactoryGirl.create(:book)
      put :update, format:'json', id:'', book:{ name:'', author:'', isbn:'', price:'', publication:'', version:'', no_of_copies:'', library_id:'', category_id:'' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do 
    it 'should be a valid Destroy Action' do 
      book = FactoryGirl.create(:book)
      delete :destroy, format:'json', id:book.id 
      response.should have_http_status(:ok)
    end  
    it 'should not be a valid Destroy Action' do 
      book = FactoryGirl.create(:book)
      delete :destroy, format:'json', id:Faker::Book.title
      response.should have_http_status(:unprocessable_entity)
    end 
    it 'should be a valid Destroy Action' do 
      book = FactoryGirl.create(:book)
      delete :destroy, format:'json', id:''
      response.should have_http_status(:unprocessable_entity)
    end 
  end
end