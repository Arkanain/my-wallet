require 'rails_helper'

describe PlacesController do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let(:place) { create(:place, user: admin) }
  let(:new_place_params) { attributes_for(:place, user_id: admin.id) }

  shared_examples 'a user' do
    it 'should get list of places' do
      2.times { create(:place, user: admin) }

      get :index

      expect(response).to render_template(:index)
      expect(assigns[:places].length).to eql(2)
    end

    it 'should show single place' do
      2.times { create(:wallet, place: place) }

      get :show, id: place

      expect(assigns[:place].name).to eq(place.name)
      expect(assigns[:place].wallets.count).to eq(2)
      expect(response).to render_template(:show)
    end
  end

  context 'as admin' do
    before(:each) do
      sign_in(:user, admin)
    end

    it_behaves_like 'a user'

    it 'should show new place page' do
      get :new

      expect(response).to render_template(:new)
      expect(assigns[:place].id).to be_nil
    end

    it 'should create new place' do
      post :create, place: new_place_params

      expect(Place.count).to eq(1)
      expect(response).to redirect_to(place_path(assigns[:place]))
    end

    it 'should show edit place page' do
      get :edit, id: place

      expect(response).to render_template(:edit)
      expect(assigns[:place]).to eq(place)
    end

    it 'should update place' do
      put :update, id: place, place: new_place_params

      expect(assigns[:place].name).to eq(new_place_params[:name])
      expect(response).to redirect_to(place_path(assigns[:place]))
    end

    it 'should destroy place' do
      new_place = create(:place, user: admin)

      expect(Place.count).to eq(1)

      delete :destroy, id: new_place

      expect(Place.count).to eq(0)
    end
  end

  context 'as user' do
    before(:each) do
      sign_in(:user, user)
    end

    it_behaves_like 'a user'

    it 'should not see new place page' do
      get :new

      expect(response).to be_forbidden
      expect(response.body).to match("You don't have permission to access to this page")
    end

    it 'should not create new place' do
      post :create, place: new_place_params

      expect(response).to be_forbidden
      expect(response.body).to match("You don't have permission to access to this page")
    end

    it 'should not see edit place page' do
      get :edit, id: place

      expect(response).to be_forbidden
      expect(response.body).to match("You don't have permission to access to this page")
    end

    it 'should not update place' do
      put :update, id: place, place: new_place_params

      expect(response).to be_forbidden
      expect(response.body).to match("You don't have permission to access to this page")
    end

    it 'should not destroy place' do
      new_place = create(:place, user: admin)

      delete :destroy, id: new_place

      expect(response).to be_forbidden
      expect(response.body).to match("You don't have permission to access to this page")
    end
  end
end