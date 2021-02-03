# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  {email: "mmt-b2019@mailinator.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "mmt-b2019-web@mailinator.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "mmt-b2019-game@mailinator.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "mo@game.at", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "ass@web.at", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil}
])
Team.create!([
  {name: "mmt-b2019-gesamt"},
  {name: "mmt-b2019-web"},
  {name: "mmt-b2019-game"}
])
TeamUser.create!([
  {user_id: 1, team_id: 1, is_admin: true},
  {user_id: 2, team_id: 2, is_admin: true},
  {user_id: 3, team_id: 3, is_admin: true},
  {user_id: 4, team_id: 1, is_admin: true},
  {user_id: 4, team_id: 3, is_admin: true},
  {user_id: 5, team_id: 1, is_admin: true},
  {user_id: 5, team_id: 2, is_admin: true}
])
Subject.create!([
  {name: "Angewandte Statistik", team_id: 1},
  {name: "Human-Computer Interaction", team_id: 1},
  {name: "Multimedia Processing", team_id: 1},
  {name: "Software Design Pattern", team_id: 1},
  {name: "Software Projektmanagement", team_id: 1},
  {name: "Forschungsmethoden (Qualitative)", team_id: 1},
  {name: "Forschungsmethoden (Quantitative)", team_id: 1},
  {name: "Teamorientierter Reflexionsprozess 1", team_id: 1},
  {name: "Backend Development", team_id: 2},
  {name: "Content Management", team_id: 2},
  {name: "Frontend Development", team_id: 2},
  {name: "Interaction Design", team_id: 2},
  {name: "Web Production Workflows", team_id: 2},
  {name: "Multimediaprojekt 2", team_id: 2},
  {name: "Game Development 1", team_id: 3},
  {name: "Mixed Reality 1", team_id: 3},
  {name: "Vertiefung Computergrafik", team_id: 3},
  {name: "Multimediaprojekt 2", team_id: 3}
])
Task.create!([
  {name: "Prototyp Design", duedate: "2021-02-02", worktype: 1, description: "Erstellen Sie einen Prototypen in Adobe XD oder Figma", subject_id: 12},
  {name: "QTFM Konzept", duedate: "2021-02-05", worktype: 0, description: "Erstellen sie ein Forschungskonzept basierend auf Ihrer Forschungsfrage in qualitative Forschungsmethoden.", subject_id: 1}
])
UserTask.create!([
  {task_id: 1, user_id: 1, status: 1},
  {task_id: 1, user_id: 4, status: 1},
  {task_id: 1, user_id: 5, status: 1},
  {task_id: 2, user_id: 2, status: 1},
  {task_id: 2, user_id: 5, status: 1}
])
