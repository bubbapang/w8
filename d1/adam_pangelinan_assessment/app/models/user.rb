# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  session_token   :string
#  password_digest :string

class User < ApplicationRecord

    before_validation :ensure_session_token

    validates :email, :session_token, :password_digest, presence: true
    validates :email, :session_token, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :notes,
        foreign_key: :author_id,
        class_name: :Note,
        dependent: :destroy

    attr_reader :password

    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)
        if @user && @user.is_valid_password?(password)
            return @user
        else
            return nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_valid_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64
    end

end
