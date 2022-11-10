alias ApiProject.Repo
alias ApiProject.HoursWorked

Repo.insert!(%HoursWorked{
  date: ~D[2022-10-31],
  normal_hours: 7.5,
  night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 7.5,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-01],
  normal_hours: 7.5,
  night_hours: 0.0,
  overtime_hours: 1.0,
  expected_worked_hours: 7.5,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-02],
  normal_hours: 0.0,
  night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 8.0,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-03],
  normal_hours: 0.0,
  night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 8.0,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-04],
  normal_hours: 0.0,
  night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 8.0,
  user_id: 3
})

Repo.insert!(%HoursWorked{
  date: ~D[2022-11-02],
  normal_hours: 4.0,
  night_hours: 3.0,
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
  user_id: 3
})
