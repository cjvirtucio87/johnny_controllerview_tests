require 'rails_helper'


describe UsersController do
  let(:user) { create(:user) }

  context "creating new user" do

    it 'redirects to the new user\'s show page' do

      post :create, :user =>attributes_for(:user,:with_attributes) 

      expect(response).to redirect_to user_path(assigns(:user))
    end

  end

  context "creating a new user without the valid attributes" do

    it 'renders the new user template' do

      post :create, :user =>attributes_for(:user,:invalid_attributes)

      expect(response).to render_template(:new)

    end

  end

end