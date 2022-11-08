alias ApiProject.Repo
alias ApiProject.User
alias ApiProject.TeamsUsers
alias ApiProject.WorkingTime
alias ApiProject.Clock
alias ApiProject.HoursWorked

defmodule ApiProject.Seeder do
  @app :miniproject01

  def insertall do
    Repo.insert!(%User{
      username: "test01",
      email: "test01@gmail.com",
      role: :general_manager
    })

    Repo.insert!(%User{
      username: "test02",
      email: "test02@gmail.com",
      role: :manager
    })

    Repo.insert!(%User{
      username: "test03",
      email: "test03@gmail.com",
      role: :employee
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
      start_of_day: ~T[16:00:00],
      end_of_day: ~T[08:00:00]
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

    Repo.insert! %HoursWorked{
      date: ~N[2022-10-31 00:00:00],
      normal_hours: 7.5,
      night_hours: 0.0,
      overtime_hours: 0.0,
      expected_worked_hours: 7.5,
      user_id: 1
    }

    Repo.insert! %HoursWorked{
      date: ~N[2022-11-01 00:00:00],
      normal_hours: 7.5,
      night_hours: 0.0,
      overtime_hours: 1.0,
      expected_worked_hours: 7.5,
      user_id: 1
    }
  end
end
