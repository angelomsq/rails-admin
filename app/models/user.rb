class User < ApplicationRecord
  attr_writer :login
  attr_accessor :terms
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :user_roles
  has_many :roles, through: :user_roles

  def has_role?(role)
    roles.where({ key: role }.compact).exists?
  end

  def get_roles 
    self.roles.pluck(:name).join(", ")
  end

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :username, uniqueness: true, presence: true
  validate :validate_username

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def messages
    # TODO: create message entity
    nil
  end

  def notifications
    # TODO: create notification entity
    nil
  end

  # Role.all.each do |role|
  #   define_method "is_#{role.name.downcase}?" do
  #     # self.role.id == "#{role.id}"
  #     self.role.id == role.id
  #   end
  # end
  # def is_admin?
  #   self.role.name == "Administrator"
  # end

  private

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

 

end
