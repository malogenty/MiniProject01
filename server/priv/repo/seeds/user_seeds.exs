alias ApiProject.{Repo, User}
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
