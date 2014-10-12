require 'rails_helper'
describe Authorization do

  describe "Authorization.find_for_auth" do

    let(:auth){
      {
        "provider" => "some-provider",
        "uid" => "ene-due-rabe",
        "credentials" => {
          "token" => "wow",
          "secret" => "so-secret"
        }
      }
    }

    context "with authorization in db" do
      let(:authorization){
        Authorization.new(
          :provider => auth['provider'],
          :uid => auth['uid'],
          :token => auth['credentials']['token'],
          :secret => auth['credentials']['secret']
        )
      }

      let(:new_authorization){ Authorization.find_for_auth(auth) }

      before do
        authorization.save!
      end

      it "finds that authorization" do
        expect(new_authorization).to eq(authorization)
      end
    end


    context "without the authorization in database" do

      let(:new_authorization){ Authorization.find_for_auth(auth) }

      it "returns fresh authorization" do
        expect(new_authorization.persisted?).to equal(false)

        expect(new_authorization.provider).to equal(auth['provider'])
        expect(new_authorization.uid).to equal(auth['uid'])
        expect(new_authorization.token).to equal(auth['credentials']['token'])
        expect(new_authorization.secret).to equal(auth['credentials']['secret'])
      end

    end

  end

end
