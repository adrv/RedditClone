class User < ActiveRecord::Base
  has_many :posts
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :generate_encrypted_id


  private

  def generate_encrypted_id
    id = SecureRandom.uuid
    if User.where(encrypted_id: id).length > 0
      generate_encrypted_id
    else
      self.encrypted_id = id
    end
  end
end
