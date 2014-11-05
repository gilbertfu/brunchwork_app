class Email < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :add_unsubscribe_hash
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
                    
  def Email.new_unsubscribe_hash
    SecureRandom.urlsafe_base64
  end
  
  private
  
    #security hole, if database is compromised, all randomly gen has is exposed to unsubscribe ppl :)
    def add_unsubscribe_hash
      self.unsubscribe_hash = Email.new_unsubscribe_hash
    end
end
