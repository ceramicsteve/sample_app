require 'spec_helper'

# format for User is
# input Name
# input Email
# input Password
# input Password_confirmation
# following tests for all these variables


describe User do

  before  do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end


  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)} #from the bcrypt gem
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}
  it { should be_valid }

  describe "remember token" do
    before{ @user.save}

    # its method() eq to
    # it { expect(@user.remember.token).not_to be_blank}
    its(:remember_token) { should_not be_blank}


  end
  describe "email address with mixed case" do
    let(:mixed_case_email) {"Foo@ExAMPle.CoM"} #creates a local example using :mixedcaseemail

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email #instance variable = local variable
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase #reloads the saved email to check if it's downcase
    end
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not prsent" do
    before { @user.email = " "}
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@baz+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid

      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.last@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase #if the email is the same with all upcases
      user_with_same_email.save
    end
    it {should_not be_valid}
  end

  describe "when password is not present" do
    before do
    @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    it {should_not be_valid}
  end

  describe "when password does not match password_confirmation" do

  before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "when password is too short" do
    before {@user.password = @user.password_confirmation = "a" * 5} #password is 5 strings
    it {should be_invalid}
  end

  describe "return value of authentiation method" do
    before {@user.save}
    let(:found_user) { User.find_by(email: @user.email)}

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid")}
      it { should_not eq user_for_invalid_password}
      specify { expect(user_for_invalid_password).to be_false}
    end
  end
  end
