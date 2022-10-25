alias ApiProject.Repo
alias ApiProject.WorkingTime

Repo.insert! %WorkingTime{
  start: ~N[2022-10-13 20:00:07],
  end: ~N[2022-10-14 21:00:07],
  user_id: 1
}
