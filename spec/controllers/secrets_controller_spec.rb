require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret,:with_attributes) }
  let(:user){ create(:user, :for_controller) }

  describe 'secrets access' do
    it 'users show page, GET #Show' do
      get :show, id: secret.id

      expect(assigns(:secret)).to eq(secret)
    end
  end

  context 'when the user is logged in' do

    before do
      session[:user_id] = user.id
    end

    it 'user can create a new secret' do

      expect{ post :create, :secret => {:title => "title", :body => "body"} }.to change(Secret,:count).by(1)

      expect(response).to redirect_to secret_path(assigns(:secret))
    end

    it 'user can access the edit secret template' do
      new_secret = create(:secret,:with_attributes,author: user)

      get :edit, id: new_secret.id

      expect(response).to render_template(:edit)
    end

    it 'user can update the secret' do
      new_secret = create(:secret,:with_attributes,author: user)

      post :update, id: new_secret.id, :secret => {:title => "new title", :body => "new body" }

      expect(response).to redirect_to secret_path(assigns(:secret))

      new_secret.reload

      expect(new_secret.title).to_not eq("title")

    end

  end


end
