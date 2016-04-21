require 'rails_helper'

describe WalletsController do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let(:place) { create(:place, user: admin) }
  let(:wallet) { create(:wallet, place: place) }
  let(:new_wallet_params) { attributes_for(:wallet) }

  shared_examples 'a user' do
    it 'should send pass to email' do
      xhr :get, :send_pass, place_id: place, wallet_id: wallet

      expect(response).to be_success
    end
  end

  context 'as admin' do
    before(:each) do
      sign_in(:user, admin)
    end

    it_behaves_like 'a user'

    it 'should show new wallet page' do
      get :new, place_id: place

      expect(response).to be_success
      expect(response).to render_template(:new)
      expect(assigns[:place]).to eq(place)
      expect(assigns[:wallet].id).to be_nil
    end

    it 'should create new wallet' do
      post :create, place_id: place, wallet: new_wallet_params

      expect(place.wallets.count).to eq(1)
      expect(assigns[:place]).to eq(place)
      expect(assigns[:wallet].title).to eq(new_wallet_params[:title])
      expect(response).to redirect_to(place)
    end
  end

  context 'as user' do
    before(:each) do
      sign_in(:user, user)
    end

    it_behaves_like 'a user'

    it 'should not show new wallet page' do
      get :new, place_id: place

      expect(response).to be_forbidden
      expect(response.body).to match("You don't have permission to access to this page")
    end

    it 'should create new wallet' do
      post :create, place_id: place, wallet: new_wallet_params

      expect(response).to be_forbidden
      expect(response.body).to match("You don't have permission to access to this page")
    end
  end
end
