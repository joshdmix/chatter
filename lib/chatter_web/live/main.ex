defmodule ChatterWeb.GithubDeployView do
  use Phoenix.LiveView

  def render(assigns) do
    Chatter.PageView.render("github_deploy.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, deploy_step: "ready")}
  end
end
