require 'rails_helper'

RSpec.describe Member, type: :model do
  context 'validation' do
    it 'should have valid attributes' do
      member = build(:member)
      member.should be_valid
    end
    it 'should not have empty name' do
      member = build(:member, name: '')
      member.should_not be_valid
    end
    it 'should not have name length less than 3' do
      member = build(:member, name: 'aa')
      member.should_not be_valid
    end
    it 'should not have empty address' do
      member = build(:member, address: '')
      member.should_not be_valid
    end
    it 'should not have address length less than 3' do
      member = build(:member, address: 'aa')
      member.should_not be_valid
    end
    it 'should not have empty phone' do
      member = build(:member, phone: '')
      member.should_not be_valid
    end
    it 'should not have phone less than 7' do
      member = build(:member, phone: '1234')
      member.should_not be_valid
    end
    it 'should not have phone more than 12' do
      member = build(:member, phone: '0909090909000900009090')
      member.should_not be_valid
    end
    it 'should not have empty is gender' do
      member = build(:member, gender: '')
      member.should_not be_valid
    end
    it 'should not have empty code' do
      member = build(:member, code: '')
      member.should_not be_valid
    end
    it 'should not have empty validity date' do
      member = build(:member, validity_date: '')
      member.should_not be_valid
    end
    it 'should not have invalide validity date' do
      member = build(:member, validity_date: 'poiuytre')
      member.should_not be_valid
    end
    it 'should not have empty is author' do
      member = build(:member, is_author: '')
      member.should_not be_valid
    end
    it 'should not have empty library id' do
      member = build(:member, library_id: '')
      member.should_not be_valid
    end
    it 'should not have invalid library id' do
      member = build(:member, library_id: 'asas')
      member.should_not be_valid
    end
  end

  context 'association' do
    it 'should have many issue histories' do
      member = create(:member)
      history1 = create(:issue_history, member_id: member.id)
      history2 = create(:issue_history, member_id: member.id)
      member.issue_histories.includes(history1, history2).should be_truthy
    end
    it 'should belong to a library' do
      library = create(:library)
      member = create(:member , library_id: library.id)
      member.library.should eq library
    end
  end
end