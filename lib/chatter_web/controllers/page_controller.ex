defmodule ChatterWeb.PageController do
  use ChatterWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, ChatterWeb.MainView, session: %{})
  end
end
