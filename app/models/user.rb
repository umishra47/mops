class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :products, dependent: :destroy
  has_many :authentications, :dependent => :delete_all
  def apply_omniauth(auth) 
    self.email = auth['info']['email'] 
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token']) 
  end
  
end
