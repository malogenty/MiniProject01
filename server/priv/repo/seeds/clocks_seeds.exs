alias ApiProject.Repo
alias ApiProject.Clock

Repo.insert! %Clock{
  status: false,
  time: ~N[2022-10-13 08:00:00],
  user_id: 3
}

Repo.insert! %Clock{
  status: false,
  time: ~N[2022-10-13 17:00:00],
  user_id: 3
}
