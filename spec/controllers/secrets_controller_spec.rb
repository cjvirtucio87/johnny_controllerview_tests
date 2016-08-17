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
      expect(flash).to_not be_nil
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

    it 'user can destroy a secret' do
      secret = create(:secret, :with_attributes, author: user)

      expect{ delete :destroy, :id => secret.id }.to change(Secret, :count).by(-1)
    end

    it 'redirects to root after destroying a secret' do
      secret = create(:secret, :with_attributes, author: user)

      delete :destroy, id: secret.id

      expect(response).to redirect_to secrets_path
    end
  end

  context "when user not logged in" do

    it 'will not have access to secret edit page' do
      get :edit, id: secret.id
      expect(response).to redirect_to new_session_path
    end

    it 'will not update a secret' do

      put :update, :id => secret.id, :secret => attributes_for(:secret, :with_attributes)

      expect(response).to redirect_to new_session_path
    end

    it 'will not delete a secret' do
      post :destroy, id: secret

      expect(response).to redirect_to new_session_path
    end

    it 'will not create a new secret' do
      post :create, secret: attributes_for(:secret, :with_attributes)

      expect(response).to redirect_to new_session_path
    end
  end

  context "accessing the edit page as a signed in user" do
    before do
      session[:user_id] = user.id
    end

    it 'sets the user instance variable' do
      new_secret = create(:secret, :with_attributes, author: user )
      get :edit, id: new_secret.id
      expect(assigns(:secret)).to eq(new_secret)
    end
  end
end
