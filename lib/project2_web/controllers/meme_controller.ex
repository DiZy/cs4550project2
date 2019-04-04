defmodule Project2Web.MemeController do
  use Project2Web, :controller

  def index(conn, _params) do
    resp = %{}
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(:created, Jason.encode!(resp))
  end
end
