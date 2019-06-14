defmodule ChatterWeb.MainView do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
    <div>
    <%= @deploy_step %>
    </div>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, deploy_step: "Okay")}
  end
end
