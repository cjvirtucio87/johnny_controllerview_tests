require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret,:with_attributes) }
  let(:user){ create(:user, :with_attributes) }

  describe 'secrets access' do
    it 'users show page, GET #Show' do
      get :show, id: secret.id

      expect(assigns(:secret)).to eq(secret)
    end
  end

  describe "creating new secret" do
    before do
      session[:user_id] = user.id
    end

    it 'signed in user can create a new secret' do
      post :create, :secret => {:title => "title", :body => "body"}

      expect(response).to redirect_to secret_path(assigns(secret))
    end
  end
end
