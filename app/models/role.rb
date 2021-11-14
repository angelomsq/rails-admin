class Role < ApplicationRecord
  has_many :users
  before_save :set_role_key

  validates :name, uniqueness: true, presence: true

  protected
  def set_role_key
    self.key = self.name.downcase.underscore
  end

end
