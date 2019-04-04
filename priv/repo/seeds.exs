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
alias Project2.UserCreatedMemes.UserCreatedMeme
alias Project2.ActiveMemes.ActiveMeme

pwhash = Argon2.hash_pwd_salt("pass1")

Repo.insert!(%User{email: "alice@example.com", admin: true, password_hash: pwhash})
Repo.insert!(%User{email: "bob@example.com", admin: false, password_hash: pwhash})
Repo.insert!(%UserCreatedMeme{image_url: "idk", text_line_one: "this is meme", text_line_two: "yay"})
Repo.insert!(%UserCreatedMeme{image_url: "idk2", text_line_one: "this is meme2", text_line_two: "yay2"})
Repo.insert!(%MemeFound{user_id: 1, gif_id: "YsTs5ltWtEhnq", is_user_created: false})
Repo.insert!(%MemeFound{user_id: 1, meme_id: 1, is_user_created: true})
Repo.insert!(%ActiveMeme{lat: 42.339411999999996, long: -71.0830491, gif_id: "l3JDFJncJHteKIYzm", is_user_created: false})
Repo.insert!(%ActiveMeme{lat: 43.339411999999996, long: -71.0830491, meme_id: 1, is_user_created: true})
