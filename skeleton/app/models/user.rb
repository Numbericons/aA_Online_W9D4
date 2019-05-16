# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: { message: 'Password can\'t be blank' } 
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 8, allow_nil: true }
    after_initialize :ensure_session_token

  
    
    def reset_session_token!
      self.session_token = User.generate_session_token
      self.save!
      self.session_token
    end

    def self.generate_session_token
      SecureRandom::urlsafe_base64(16)
    end

    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end
    
    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
    
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return unless user
        user.is_password?(password) ? user : nil
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end
end