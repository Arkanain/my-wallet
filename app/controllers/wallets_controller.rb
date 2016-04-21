class WalletsController < ApplicationController
  load_and_authorize_resource find_by: :id

  def new
    @place = Place.find_by(params[:place_id])
    @wallet = @place.wallets.build
  end

  def create
    @place = Place.find_by(params[:place_id])
    @wallet = @place.wallets.create(params[:wallet])

    redirect_to place_path(@place)
  end

  def send_pass
    @wallet = Wallet.find_by(id: params[:wallet_id])

    @wallet.transaction do
      @wallet.user_wallets.create(user: current_user, serial_number: Faker::Company.swedish_organisation_number)

      WalletMailer.send_wallet_email(current_user.id, params[:wallet_id]).deliver_now
    end

    respond_to do |format|
      format.js { render nothing: true, status: :ok }
    end
  end
end