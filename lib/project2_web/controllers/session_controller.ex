defmodule Project2Web.SessionController do
    use Project2Web, :controller

    alias Project2.Users.User;
  
    def create(conn, %{"email" => email, "password" => password}) do
      with %User{} = user <- Project2.Users.get_and_auth_user(email, password) do
        token = Phoenix.Token.sign(Project2Web.Endpoint, "user_id", user.id)
        resp = %{
          data: %{
            user_token: token,
            user_id: user.id,
          }
        }
        conn
        |> put_session(:user_id, user.id)
        |> put_session(:user_token, token)
        |> put_resp_header("content-type", "application/json; charset=utf-8")
        |> send_resp(:created, Jason.encode!(resp))
      end
    end

    def delete(conn, _params) do
      conn
      |> delete_session(:user_id)
      |> delete_session(:user_token)
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> send_resp(:ok, Jason.encode!(%{status: true}))
    end
  end