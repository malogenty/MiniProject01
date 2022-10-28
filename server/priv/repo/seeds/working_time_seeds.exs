alias ApiProject.Repo
alias ApiProject.WorkingTime

Repo.insert! %WorkingTime{
  start: ~N[2022-10-13 08:00:00],
  end: ~N[2022-10-14 17:30:00],
  user_id: 1
}

Repo.insert! %WorkingTime{
  start: ~N[2022-10-13 09:30:00],
  end: ~N[2022-10-14 18:00:00],
  user_id: 2
}

Repo.insert! %WorkingTime{
  start: ~N[2022-10-13 09:00:00],
  end: ~N[2022-10-14 17:30:00],
  user_id: 1
}
