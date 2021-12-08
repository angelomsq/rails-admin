class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  before_save :set_role_key

  validates :name, uniqueness: true, presence: true

  def permissions=(permissions)
    self.permissions_mask = (permissions & RolePermissions.list).map { |r| 2**RolePermissions.list.index(r) }.inject(0, :+)
  end
  
  def permissions
    RolePermissions.list.reject do |r|
      ((permissions_mask.to_i || 0) & 2**RolePermissions.list.index(r)).zero?
    end
  end

  def has_permission?(permission)
    self.permissions.include?(permission)
  end

  def get_permissions 
    permissions = [*self.permissions].map { |r| RolePermissions.t(r) }
    permissions.to_sentence(locale: "pt-BR")
  end

  protected
  def set_role_key
    self.key = self.name.downcase.underscore
  end

end
