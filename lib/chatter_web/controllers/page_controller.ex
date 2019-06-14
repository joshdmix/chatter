defmodule ChatterWeb.PageController do
  use ChatterWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, ChatterWeb.MainView, session: %{})
  end

  def handle_event("github_deploy", _value, socket) do
    :ok = Chatter.start_deploy()
    send(self(), :create_org)
    {:noreply, assign(socket, deploy_step: "Starting deploy...")}
  end

  def handle_info(:create_org, socket) do
    {:ok, org} = Chatter.create_org()
    send(self(), {:create_repo, org})
    {:noreply, assign(socket, deploy_step: "Creating GitHub org")}
  end

  def handle_info({:create_repo, org}, socket) do
    {:ok, repo} = Chatter.create_repo(org)
    send(self(), {:push_contents, repo})
    {:noreply, assign(socket, deploy_step: "Creating GitHub repo")}
  end

  def handle_info({:push_contents, repo}, socket) do
    :ok = Chatter.push_contents(repo)
    send(self(), :done)
    {:noreply, assign(socket, deploy_step: "Pushing to repo...")}
  end

  def handle_info(:done, socket) do
    {:noreply, assign(socket, deploy_step: "Done!")}
  end
end
