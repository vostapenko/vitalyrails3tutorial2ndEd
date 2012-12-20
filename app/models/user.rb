class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :locale, :active
  has_secure_password

  scope :active, where(active: true)

  has_many :microposts, dependent: :destroy
  has_many :relationships,         foreign_key: "follower_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", 
                                   class_name: "Relationship", 
                                   dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { self.email.downcase! }
  before_save :create_remember_token
  before_save :send_activation


  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { within: 6..40 }, on: :create
  validates :password, presence: true, length: { within: 6..40 }, on: :update, unless: lambda{ |user| user.password.to_s.empty? } 
  validates :password_confirmation, presence: true, on: :create

  LOCALE = ['en', 'ru']

  def send_password_reset
    generate_token
    set_time
    save!
    UserMailer.password_reset(self).deliver
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
     self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
     self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
     self.relationships.find_by_followed_id(other_user.id).destroy          
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def generate_token
    self.password_reset_token = SecureRandom.urlsafe_base64
  end

  def activation
    self.activation_token = SecureRandom.urlsafe_base64
  end

  def set_time
    self.password_reset_sent_at = Time.zone.now
  end

  def send_activation                    
    unless self.active?                      
      create_remember_token              
      activation                         
      UserMailer.activation(self).deliver
    end
  end                                    
end
