class User < ActiveRecord::Base
  #has_and_belongs_to_many :events
  has_one :photo, as: :imageable
  has_many :comments, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :events
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  mount_uploader :image, ImageUploader
  mount_uploader :resume, ResumeUploader
  
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
        # Returns true if the given token matches the digest.
  def act_authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    return Digest::SHA1.hexdigest(token.to_s) == digest
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_remember_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # Sends password reset email.
  def send_password_reset_email
    MyMailer.password_reset(self).deliver
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
    
    def create_activation_digest
      self.activation_token = User.new_remember_token
      self.activation_digest = User.digest(activation_token)
    end
    
end
