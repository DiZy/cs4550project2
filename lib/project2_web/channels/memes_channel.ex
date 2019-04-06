defmodule Project2Web.MemeChannel do
  use Project2Web, :channel

  def join("memes", payload, socket) do
    if authorized?(payload) do
      {:ok, %{}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  
  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end