class WalletMailer < ApplicationMailer
  def send_wallet_email(user_id, wallet_id)
    @user = User.find_by(id: user_id)
    @wallet = Wallet.find_by(id: wallet_id)

    attachments['test.pkpass'] = File.read("#{Rails.root}/app/attachments/test.pkpass")

    # mail(to: @user.email, subject: 'Your Wallet')
    mail(to: 'arkanainKiller@gmail.com', subject: 'Your Wallet')
  end
end
