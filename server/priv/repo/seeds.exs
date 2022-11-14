# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ApiProject.Repo.insert!(%ApiProject.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ApiProject.{Repo, User, TeamsUsers, Team, Clock, HoursWorked, WorkingTime, Schedule}
import Bcrypt

Repo.insert!(%User{
  username: "test01",
  email: "test01@gmail.com",
  role: :general_manager,
  password_hash: Bcrypt.hash_pwd_salt("password")
})

Repo.insert!(%User{
  username: "test02",
  email: "test02@gmail.com",
  role: :manager,
  password_hash: Bcrypt.hash_pwd_salt("password")
})

Repo.insert!(%User{
  username: "test03",
  email: "test03@gmail.com",
  role: :employee,
  password_hash: Bcrypt.hash_pwd_salt("password")
})

Repo.insert!(%Team{
  name: "First Team",
  start_of_day: ~T[08:00:00],
  end_of_day: ~T[17:00:00]
})

Repo.insert!(%Team{
  name: "Second Team",
  start_of_day: ~T[09:00:00],
  end_of_day: ~T[20:00:00]
})

Repo.insert!(%Team{
  name: "Dream Team",
  start_of_day: ~T[08:00:00],
  end_of_day: ~T[16:00:00]
})

Repo.insert!(%TeamsUsers{
  user_id: 1,
  team_id: 1
})

Repo.insert!(%TeamsUsers{
  user_id: 1,
  team_id: 2
})

Repo.insert!(%TeamsUsers{
  user_id: 1,
  team_id: 3
})

Repo.insert!(%TeamsUsers{
  user_id: 2,
  team_id: 1
})

Repo.insert!(%TeamsUsers{
  user_id: 2,
  team_id: 2
})

Repo.insert!(%TeamsUsers{
  user_id: 3,
  team_id: 3
})

Repo.insert!(%WorkingTime{
  start: ~N[2022-10-13 08:00:00],
  end: ~N[2022-10-14 17:30:00],
  user_id: 1
})

Repo.insert!(%WorkingTime{
  start: ~N[2022-10-13 09:30:00],
  end: ~N[2022-10-14 18:00:00],
  user_id: 2
})

Repo.insert!(%WorkingTime{
  start: ~N[2022-10-13 09:00:00],
  end: ~N[2022-10-14 17:30:00],
  user_id: 1
})

Repo.insert!(%Clock{
  status: false,
  time: ~N[2022-10-13 08:00:00],
  user_id: 3
})

Repo.insert!(%Clock{
  status: false,
  time: ~N[2022-10-13 17:00:00],
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-10-31],
  normal_hours: 7.5,
  night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 7.5,
  overtime_night_hours: 0.0,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-01],
  normal_hours: 7.5,
  night_hours: 0.0,
  overtime_hours: 1.0,
  overtime_night_hours: 0.0,
  expected_worked_hours: 7.5,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-02],
  normal_hours: 0.0,
  night_hours: 0.0,
  overtime_night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 8.0,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-03],
  normal_hours: 0.0,
  night_hours: 0.0,
  overtime_hours: 0.0,
  overtime_night_hours: 0.0,
  expected_worked_hours: 8.0,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-04],
  normal_hours: 0.0,
  night_hours: 0.0,
  overtime_night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 8.0,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-02],
  normal_hours: 4.0,
  night_hours: 3.0,
  overtime_night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 7.5,
  user_id: 2
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-02],
  normal_hours: 6.0,
  night_hours: 0.0,
  overtime_hours: 2.0,
  expected_worked_hours: 7.5,
  overtime_night_hours: 0.0,
  user_id: 3
})

Repo.insert!(%Schedule{
  start: ~N[2022-11-02 08:00:00],
  end: ~N[2022-11-02 12:00:00],
  duration: 4.0,
  title: :work,
  user_id: 3
})

Repo.insert!(%Schedule{
  start: ~N[2022-11-02 13:00:00],
  end: ~N[2022-11-02 17:00:00],
  duration: 4.0,
  title: :work,
  user_id: 3
})

Repo.insert!(%Schedule{
  start: ~N[2022-11-03 08:00:00],
  end: ~N[2022-11-03 12:00:00],
  duration: 4.0,
  title: :work,
  user_id: 3
})

Repo.insert!(%Schedule{
  start: ~N[2022-11-03 13:00:00],
  end: ~N[2022-11-03 17:00:00],
  duration: 4.0,
  title: :work,
  user_id: 3
})

Repo.insert!(%Schedule{
  start: ~N[2022-11-04 08:00:00],
  end: ~N[2022-11-04 12:00:00],
  duration: 4.0,
  title: :work,
  user_id: 3
})

Repo.insert!(%Schedule{
  start: ~N[2022-11-04 13:00:00],
  end: ~N[2022-11-04 17:00:00],
  duration: 4.0,
  title: :work,
  user_id: 3
})
