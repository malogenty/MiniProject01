alias ApiProject.Repo
alias ApiProject.Team

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
