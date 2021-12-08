class RolePermissions < EnumerateIt::Base
  associate_values(
    :manage__user, :read__user, :create__user, :update__user, :destroy__user,
    :manage__role, :read__role, :create__role, :update__role, :destroy__role
  )
end
