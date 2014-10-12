require 'rails_helper'
describe User do
  describe "User.new_from_auth" do

    let(:name){ "Zbigniew" }
    let(:email) { "zbigniew@wodecki.com" }
    let(:auth_hash){
      { "info" =>
        { "name" => name, "email" => email }
      }
    }

    let(:user){ User.new_from_auth(auth_hash) }

    it "returns new user based on hash" do
      expect(user.name).to equal(name)
      expect(user.email).to equal(email)
      expect(user.persisted?).to equal(false)
    end

    let(:stupid_password){ 'Kto nie skacze ten z policji'}

    it "has password set to whatever 'random_password' returns" do
      expect(User).to receive(:random_password).and_return(stupid_password)
      expect(user.password).to equal(stupid_password)
    end

  end

end
