require 'rails_helper'

describe "secrets/index.html.erb" do
  let(:user) { create(:user, :for_controller)}
  before do
    @user = user
    def view.current_user
      @user
    end
  end

  let(:secret){ create(:secret, :with_attributes, author: user) }

  context "when user is not logged in" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it 'does not show author of secret when user not logged in' do
      secrets = [secret, create(:secret, :with_attributes)]

      assign(:secrets, secrets)

      render

      expect(rendered).to match(/\*\*hidden\*\*/)
    end

    it 'does nto show the logout link' do
      secrets = [secret, create(:secret, :with_attributes)]
      assign(:secrets, secrets)

      render

      expect(rendered).not_to have_selector("a[href='#{session_path}']", text: "Logout")
    end
  end

  context "when user is not logged in" do
    before do
      def view.signed_in_user?
        true
      end
    end

    it 'shows author of secret when user logged in' do
      secrets = [secret, create(:secret, :with_attributes)]

      assign(:secrets, secrets)

      render

      expect(rendered).not_to match(/\*\*hidden\*\*/)
    end

    it 'does nto show the logout link' do
      secrets = [secret, create(:secret, :with_attributes)]
      assign(:secrets, secrets)

      render template: 'secrets/index', layout: 'layouts/application'
      
      expect(rendered).to match(/Logout/)
    end
  end
end
