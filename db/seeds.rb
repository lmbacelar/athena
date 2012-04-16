# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.create(email: 'lmbacelar@gmail.com',
            name: 'Luis Bacelar',
            password: 'secret',
            password_confirmation: 'secret').update_attribute(:active, true)
l1 = Category.create  name: 'Manual da Qualidade',
                      acronym: 'MQ',
                      level: 1
mq = l1.documents.create name: '01',
                         title: 'Manual da Qualidade',
                         description: 'Manual da Qualidade do Laboratorio de Calibracoes da TAP Portugal'
v1 = mq.versions.create
