alias ApiProject.Repo
alias ApiProject.User

Repo.insert! %User{
  username: "test01",
  email: "test01@gmail.com"
}

Repo.insert! %User{
  username: "test02",
  email: "test02@gmail.com"
}

Repo.insert! %User{
  username: "test03",
  email: "test03@gmail.com"
}
