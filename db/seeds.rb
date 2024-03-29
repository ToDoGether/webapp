# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env != 'production'

  # Semester 1 & 2
  ## Admin
  user_mmtb1_admin = User.create(email: 'sepp-the-admin@mailinator.com', password: '123456')
  ## Users
  user_mmtb1_01 = User.create(email: 'emma@mailinator.com',   password: '123456')
  user_mmtb1_02 = User.create(email: 'maxi@mailinator.com',   password: '123456')
  user_mmtb1_03 = User.create(email: 'anna@mailinator.com',   password: '123456')
  user_mmtb1_04 = User.create(email: 'paul@mailinator.com',   password: '123456')
  user_mmtb1_05 = User.create(email: 'emilia@mailinator.com', password: '123456')
  user_mmtb1_06 = User.create(email: 'jakob@mailinator.com',  password: '123456')
  user_mmtb1_07 = User.create(email: 'marie@mailinator.com',  password: '123456')
  user_mmtb1_08 = User.create(email: 'david@mailinator.com',  password: '123456')
  user_mmtb1_09 = User.create(email: 'mia@mailinator.com',    password: '123456')
  user_mmtb1_10 = User.create(email: 'felix@mailinator.com',  password: '123456')
  # Semester 3 & 4
  ## Admin
  user_mmtb2_admin = User.create(email: 'berni-the-admin@mailinator.com', password: '123456')
  ## Users
  user_mmtb2_01 = User.create(email: 'lena@mailinator.com',      password: '123456')
  user_mmtb2_02 = User.create(email: 'elias@mailinator.com',     password: '123456')
  user_mmtb2_03 = User.create(email: 'laura@mailinator.com',     password: '123456')
  user_mmtb2_04 = User.create(email: 'lukas@mailinator.com',     password: '123456')
  user_mmtb2_05 = User.create(email: 'johanna@mailinator.com',   password: '123456')
  user_mmtb2_06 = User.create(email: 'jonas@mailinator.com',     password: '123456')
  user_mmtb2_07 = User.create(email: 'lea@mailinator.com',       password: '123456')
  user_mmtb2_08 = User.create(email: 'alexander@mailinator.com', password: '123456')
  user_mmtb2_09 = User.create(email: 'valentina@mailinator.com', password: '123456')
  user_mmtb2_10 = User.create(email: 'leon@mailinator.com',      password: '123456')

  # Teams for semester 1-4
  team_mmtb_s1 = Team.create(name: 'mmtb-s1')
  team_mmtb_s2 = Team.create(name: 'mmtb-s2')
  team_mmtb_s3_general = Team.create(name: 'mmtb-s3-allgemein')
  team_mmtb_s3_game = Team.create(name: 'mmtb-s3-game')
  team_mmtb_s3_web = Team.create(name: 'mmtb-s3-web')
  team_mmtb_s4_general = Team.create(name: 'mmtb-s4-allgemein')
  team_mmtb_s4_game = Team.create(name: 'mmtb-s4-game')
  team_mmtb_s4_web = Team.create(name: 'mmtb-s4-web')

  # Link between teams and users
  team_1_admin = TeamUser.create(user_id: user_mmtb1_admin.id, team_id: team_mmtb_s1.id, is_admin: true)
  team_1_admin = TeamUser.create(user_id: user_mmtb1_admin.id, team_id: team_mmtb_s2.id, is_admin: true)
  team_1_user_01 = TeamUser.create(user_id: user_mmtb1_01.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_02 = TeamUser.create(user_id: user_mmtb1_02.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_03 = TeamUser.create(user_id: user_mmtb1_03.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_04 = TeamUser.create(user_id: user_mmtb1_04.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_05 = TeamUser.create(user_id: user_mmtb1_05.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_06 = TeamUser.create(user_id: user_mmtb1_06.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_07 = TeamUser.create(user_id: user_mmtb1_07.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_08 = TeamUser.create(user_id: user_mmtb1_08.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_09 = TeamUser.create(user_id: user_mmtb1_09.id, team_id: team_mmtb_s1.id, is_admin: false)
  team_1_user_10 = TeamUser.create(user_id: user_mmtb1_10.id, team_id: team_mmtb_s1.id, is_admin: false)

  team_3_admin = TeamUser.create(user_id: user_mmtb2_admin.id, team_id: team_mmtb_s3_general.id, is_admin: true)
  team_3_admin = TeamUser.create(user_id: user_mmtb2_admin.id, team_id: team_mmtb_s4_general.id, is_admin: true)
  team_3_user_01 = TeamUser.create(user_id: user_mmtb2_01.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_02 = TeamUser.create(user_id: user_mmtb2_02.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_03 = TeamUser.create(user_id: user_mmtb2_03.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_04 = TeamUser.create(user_id: user_mmtb2_04.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_05 = TeamUser.create(user_id: user_mmtb2_05.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_06 = TeamUser.create(user_id: user_mmtb2_06.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_07 = TeamUser.create(user_id: user_mmtb2_07.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_08 = TeamUser.create(user_id: user_mmtb2_08.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_09 = TeamUser.create(user_id: user_mmtb2_09.id, team_id: team_mmtb_s3_general.id, is_admin: false)
  team_3_user_10 = TeamUser.create(user_id: user_mmtb2_10.id, team_id: team_mmtb_s3_general.id, is_admin: false)

  # Subjects for all the mmt semesters
  ## Subjects for the first semester
  subject_mmt_3dm = Subject.create(team_id: team_mmtb_s1.id, name: '3D Modellierung und Animation')
  subject_mmt_am1 = Subject.create(team_id: team_mmtb_s1.id, name: 'Angewandte Mathematik 1')
  subject_mmt_ecn = Subject.create(team_id: team_mmtb_s1.id, name: 'Einführung Computernetzwerke')
  subject_mmt_edb = Subject.create(team_id: team_mmtb_s1.id, name: 'Einführung Datenbanken')
  subject_mmt_els = Subject.create(team_id: team_mmtb_s1.id, name: 'English Language Skills')
  subject_mmt_cda = Subject.create(team_id: team_mmtb_s1.id, name: 'Konzeptentwicklung (MMA)')
  subject_mmt_cdt = Subject.create(team_id: team_mmtb_s1.id, name: 'Konzeptentwicklung (MMT)')
  subject_mmt_emm = Subject.create(team_id: team_mmtb_s1.id, name: 'Einführung Multimedia')
  subject_mmt_pr1 = Subject.create(team_id: team_mmtb_s1.id, name: 'Personaler Reflexionsprozess 1')
  subject_mmt_pav = Subject.create(team_id: team_mmtb_s1.id, name: 'Praxis audiovisuelle Medien')
  subject_mmt_epg = Subject.create(team_id: team_mmtb_s1.id, name: 'Einführung Programmierung')
  subject_mmt_wp1 = Subject.create(team_id: team_mmtb_s1.id, name: 'Web Programmierung 1')
  ## Subjects for the second semester
  subject_mmt_ads = Subject.create(team_id: team_mmtb_s2.id, name: 'Algorithmen und Datenstrukturen')
  subject_mmt_am2 = Subject.create(team_id: team_mmtb_s2.id, name: 'Angewandte Mathematik 2')
  subject_mmt_ecg = Subject.create(team_id: team_mmtb_s2.id, name: 'Einführung Computergrafik')
  subject_mmt_ito = Subject.create(team_id: team_mmtb_s2.id, name: 'IT Operations')
  subject_mmt_emg = Subject.create(team_id: team_mmtb_s2.id, name: 'Einführung Mediengestaltung')
  subject_mmt_mm1 = Subject.create(team_id: team_mmtb_s2.id, name: 'Multimediaprojekt 1 (MMP1)')
  subject_mmt_pr2 = Subject.create(team_id: team_mmtb_s2.id, name: 'Personaler Reflexionsprozess 2')
  subject_mmt_apm = Subject.create(team_id: team_mmtb_s2.id, name: 'Projektmanagement')
  subject_mmt_apt = Subject.create(team_id: team_mmtb_s2.id, name: 'Präsentationstechniken')
  subject_mmt_wp2 = Subject.create(team_id: team_mmtb_s2.id, name: 'Web Programmierung 2')
  subject_mmt_war = Subject.create(team_id: team_mmtb_s2.id, name: 'Wissenschaftliches Arbeiten')
  ## Subjects for the third semester - General
  subject_mmt_ast = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Angewandte Statistik')
  subject_mmt_hci = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Human-Computer Interaction')
  subject_mmt_mpr = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Multimedia Processing')
  subject_mmt_sdp = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Software Design Pattern')
  subject_mmt_spm = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Software Projektmanagement')
  subject_mmt_fmt = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Forschungsmethoden (Quantitative)')
  subject_mmt_fml = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Forschungsmethoden (Qualitative)')
  subject_mmt_tr1 = Subject.create(team_id: team_mmtb_s3_general.id, name: 'Teamorientierter Reflexionsprozess 1')
  ## Subjects for the third semester - Game
  subject_mmt_gd1 = Subject.create(team_id: team_mmtb_s3_game.id, name: 'Game Development 1')
  subject_mmt_mr1 = Subject.create(team_id: team_mmtb_s3_game.id, name: 'Mixed Reality 1')
  subject_mmt_vcg = Subject.create(team_id: team_mmtb_s3_game.id, name: 'Vertiefung Computergrafik')
  subject_mmt_gp2 = Subject.create(team_id: team_mmtb_s3_game.id, name: 'Multimediaprojekt 2 (MMP2a)')
  ## Subjects for the third semester - Web
  subject_mmt_bed = Subject.create(team_id: team_mmtb_s3_web.id, name: 'Backend Development')
  subject_mmt_cms = Subject.create(team_id: team_mmtb_s3_web.id, name: 'Content Management')
  subject_mmt_fed = Subject.create(team_id: team_mmtb_s3_web.id, name: 'Frontend Development')
  subject_mmt_iad = Subject.create(team_id: team_mmtb_s3_web.id, name: 'Interaction Design')
  subject_mmt_wpw = Subject.create(team_id: team_mmtb_s3_web.id, name: 'Web Production Workflows')
  subject_mmt_wm2 = Subject.create(team_id: team_mmtb_s3_web.id, name: 'Multimediaprojekt 2 (MMP2a)')
  ## Subjects for the fourth semester - General
  subject_mmt_sai = Subject.create(team_id: team_mmtb_s4_general.id, name: 'Seminararbeit aus Informatik')
  subject_mmt_cds = Subject.create(team_id: team_mmtb_s4_general.id, name: 'Concurrent und Distributed Systems')
  subject_mmt_hcs = Subject.create(team_id: team_mmtb_s4_general.id, name: 'HCI-Studio')
  subject_mmt_crm = Subject.create(team_id: team_mmtb_s4_general.id, name: 'Kryptographie und Mediensicherheit')
  subject_mmt_m2b = Subject.create(team_id: team_mmtb_s4_general.id, name: 'Multimediaprojekt 2 (MMP2b)')
  subject_mmt_tr2 = Subject.create(team_id: team_mmtb_s4_general.id, name: 'Teamorientierter Reflexionsprozess 2')

  # Task creation
  ## Tasks for the first semester
  task_1_s1_3dm = Task.create(duedate: Date.today + 1, worktype: false, subject_id: subject_mmt_3dm.id,
                              name: '3D Hausübung')
  task_2_s1_3dm = Task.create(duedate: Date.today + 100, worktype: false, subject_id: subject_mmt_3dm.id,
                              name: '3D Projekt')
  task_3_s1_am1 = Task.create(duedate: Date.today +   3, worktype: false, subject_id: subject_mmt_3dm.id,
                              name: 'Mathe HÜ1')
  task_4_s1_am1 = Task.create(duedate: Date.today +   7, worktype: false, subject_id: subject_mmt_3dm.id,
                              name: 'Mathe HÜ2')
  task_5_s1_am1 = Task.create(duedate: Date.today +  17, worktype: false, subject_id: subject_mmt_3dm.id,
                              name: 'Mathe HÜ3')
  task_6_s1_am1 = Task.create(duedate: Date.today +  31, worktype: false, subject_id: subject_mmt_3dm.id,
                              name: 'Mathe HÜ4')
  task_7_s1_am1 = Task.create(duedate: Date.today +  49, worktype: false, subject_id: subject_mmt_3dm.id,
                              name: 'Mathe HÜ5')

  # Link user to task with default state
  ## Link user of the first semester to tasks
  task1_user_admin = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_admin.id, status: 1)
  task1_user01 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_01.id, status: 1)
  task1_user02 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_02.id, status: 1)
  task1_user03 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_03.id, status: 1)
  task1_user04 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_04.id, status: 1)
  task1_user05 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_05.id, status: 1)
  task1_user06 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_06.id, status: 1)
  task1_user07 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_07.id, status: 1)
  task1_user08 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_08.id, status: 1)
  task1_user09 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_09.id, status: 1)
  task1_user10 = UserTask.create(task_id: task_1_s1_3dm.id, user_id: user_mmtb1_10.id, status: 1)

  task2_user_admin = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_admin.id, status: 1)
  task2_user01 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_01.id, status: 1)
  task2_user02 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_02.id, status: 1)
  task2_user03 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_03.id, status: 1)
  task2_user04 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_04.id, status: 1)
  task2_user05 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_05.id, status: 1)
  task2_user06 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_06.id, status: 1)
  task2_user07 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_07.id, status: 1)
  task2_user08 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_08.id, status: 1)
  task2_user09 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_09.id, status: 1)
  task2_user10 = UserTask.create(task_id: task_2_s1_3dm.id, user_id: user_mmtb1_10.id, status: 1)

  task3_user_admin = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_admin.id, status: 1)
  task3_user01 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_01.id, status: 1)
  task3_user02 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_02.id, status: 1)
  task3_user03 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_03.id, status: 1)
  task3_user04 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_04.id, status: 1)
  task3_user05 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_05.id, status: 1)
  task3_user06 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_06.id, status: 1)
  task3_user07 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_07.id, status: 1)
  task3_user08 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_08.id, status: 1)
  task3_user09 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_09.id, status: 1)
  task3_user10 = UserTask.create(task_id: task_3_s1_am1.id, user_id: user_mmtb1_10.id, status: 1)

  task4_user_admin = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_admin.id, status: 1)
  task4_user01 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_01.id, status: 1)
  task4_user02 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_02.id, status: 1)
  task4_user03 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_03.id, status: 1)
  task4_user04 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_04.id, status: 1)
  task4_user05 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_05.id, status: 1)
  task4_user06 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_06.id, status: 1)
  task4_user07 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_07.id, status: 1)
  task4_user08 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_08.id, status: 1)
  task4_user09 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_09.id, status: 1)
  task4_user10 = UserTask.create(task_id: task_4_s1_am1.id, user_id: user_mmtb1_10.id, status: 1)

  task5_user_admin = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_admin.id, status: 1)
  task5_user01 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_01.id, status: 1)
  task5_user02 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_02.id, status: 1)
  task5_user03 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_03.id, status: 1)
  task5_user04 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_04.id, status: 1)
  task5_user05 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_05.id, status: 1)
  task5_user06 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_06.id, status: 1)
  task5_user07 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_07.id, status: 1)
  task5_user08 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_08.id, status: 1)
  task5_user09 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_09.id, status: 1)
  task5_user10 = UserTask.create(task_id: task_5_s1_am1.id, user_id: user_mmtb1_10.id, status: 1)

  task6_user_admin = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_admin.id, status: 1)
  task6_user01 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_01.id, status: 1)
  task6_user02 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_02.id, status: 1)
  task6_user03 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_03.id, status: 1)
  task6_user04 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_04.id, status: 1)
  task6_user05 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_05.id, status: 1)
  task6_user06 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_06.id, status: 1)
  task6_user07 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_07.id, status: 1)
  task6_user08 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_08.id, status: 1)
  task6_user09 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_09.id, status: 1)
  task6_user10 = UserTask.create(task_id: task_6_s1_am1.id, user_id: user_mmtb1_10.id, status: 1)

  task7_user_admin = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_admin.id, status: 1)
  task7_user01 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_01.id, status: 1)
  task7_user02 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_02.id, status: 1)
  task7_user03 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_03.id, status: 1)
  task7_user04 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_04.id, status: 1)
  task7_user05 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_05.id, status: 1)
  task7_user06 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_06.id, status: 1)
  task7_user07 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_07.id, status: 1)
  task7_user08 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_08.id, status: 1)
  task7_user09 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_09.id, status: 1)
  task7_user10 = UserTask.create(task_id: task_7_s1_am1.id, user_id: user_mmtb1_10.id, status: 1)

end
