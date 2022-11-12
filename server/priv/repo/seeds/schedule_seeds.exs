alias ApiProject.{Repo, Schedule}

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
