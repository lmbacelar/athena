# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create Roles
['admin', 'publisher', 'checker', 'writer', 'reader'].each do |r|
  Role.create name: r
end

# Create Groups
['management', 'technical'].each do |g|
  Group.create name: g
end

# Create User
User.create(email: 'lmbacelar@gmail.com',
            name: 'Luis Bacelar',
            password: 'secret',
            password_confirmation: 'secret').update_attribute(:active, true)

#Assign Memberships

# Create Categories
l1 = Category.create  name: 'Manual da Qualidade',
                      acronym: 'MQ',
                      level: 1

# Create Documents / Versions
mq = l1.documents.create name: '01',
                         title: 'Manual da Qualidade',
                         description: 'Manual da Qualidade do Laboratorio de Calibracoes da TAP Portugal'
v1 = mq.versions.create
