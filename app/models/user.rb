class User < ApplicationRecord
  validates :gender, :age, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  before_save {self.username.downcase!}
  enum gender: { keep_secrect: 0, male: 1, female: 2}
  has_secure_password

  def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                            BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
