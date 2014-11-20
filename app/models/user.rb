class User < ActiveRecord::Base
  validates_uniqueness_of :email
  after_create :send_email

private

  def send_email
    UserMailer.daily_email(self).deliver
  end

end
