# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Project2.Repo.insert!(%Project2.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Project2.Repo
alias Project2.Users.User
alias Project2.MemesFound.MemeFound

pwhash = Argon2.hash_pwd_salt("pass1")

Repo.insert!(%User{email: "alice@example.com", admin: true, password_hash: pwhash})
Repo.insert!(%User{email: "bob@example.com", admin: false, password_hash: pwhash})
Repo.insert!(%MemeFound{user_id: 1, gif_id: "YsTs5ltWtEhnq", is_user_created: false})