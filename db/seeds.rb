# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
adminRole = Role.find_or_create_by({ name: 'Admin', description: 'Can manage everything.' })
coordRole = Role.find_or_create_by({ name: 'Coord', description: 'Can manage All Users and Projects.' })
teacherRole = Role.find_or_create_by({ name: 'Teacher', description: 'Can view protected content and manage his own students.' })
studentRole = Role.find_or_create_by({ name: 'Student', description: 'Can view his projects and manage his own account.' })
adminUser = User.new(
  :username              => "admin",
  :email                 => "admin@example.com",
  :password              => "123123",
  :password_confirmation => "123123"
)
adminUser.skip_confirmation!
adminUser.roles << adminRole
adminUser.save!
# adminUser = User.create({ username: 'admin', email: 'admin@example.com', password: '123123', password_confirmation: '123123', role_id: adminRole.id })