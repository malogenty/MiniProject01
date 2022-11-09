alias ApiProject.Repo
alias ApiProject.TeamsUsers

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
