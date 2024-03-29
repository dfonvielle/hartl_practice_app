# == Schema Information
#
# Table name: cool_users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

require 'spec_helper'

describe CoolUser do
  
  before { @user = CoolUser.new(name: "Dave", email: "dave@dave.com", 
           password: "foobar", password_confirmation: "foobar") }
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to (:email) }
  it { should respond_to (:password_digest) }
  it { should respond_to (:password) }
  it { should respond_to (:password_confirmation) }
  it { should respond_to (:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do 
    before {@user.email = " "}
    it {should_not be_valid}
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51}
    it {should_not be_valid}  
  end
  
  describe "when email is invalid" do
    invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    invalid_addresses.each do |invalid_address|
      before {@user.email = invalid_address}
      it {should_not be_valid}
    end
  end
  
  describe "when email is valid" do
    valid_addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    valid_addresses.each do |valid_address|
      before {@user.email = valid_address}
      it {should be_valid}
    end
  end
  
  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = user_with_same_email.email.upcase
      user_with_same_email.save
    end 
    it {should_not be_valid}
  end
  
  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end
  
  describe "when password doesn't match confirmation" do
    before {@user.password_confirmation = "nonmatching"}
    it {should_not be_valid}
  end
  
  describe "when password confirmation is nil" do
    before {@user.password_confirmation = nil}
    it {should_not be_valid}
  end
  
  describe "return value of authenticate method" do
    before {@user.save}
    let(:found_user) {CoolUser.find_by_email(@user.email)}
    
    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end
    
    describe "with invalid password" do
      let(:user_with_invalid_password) {found_user.authenticate("boguspassword") }
      
      it {should_not == user_with_invalid_password}
      specify {user_with_invalid_password.should be_false}
    end
  end
  
  describe "with a password that's too short" do
    before {@user.password = @user.password_confirmation = "a" * 5}
    it {should_not be_valid}
  end
  
  
end




