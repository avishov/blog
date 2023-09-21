defmodule BlogWeb.PostLive.Show do
  use Phoenix.LiveView,
    layout: {BlogWeb.Layouts, :blog}

  alias Blog.Posts

  @impl true
  def mount(%{"id" => post_id} = _params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Blog.PubSub, "comments_added:#{post_id}")
      Phoenix.PubSub.subscribe(Blog.PubSub, "comments_deleted:#{post_id}")
    end

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, Posts.get_post!(id))}
  end

  @impl true
  def handle_event("create_comment", %{"comment" => comment} = _params, socket) do
    case Posts.create_comment(comment) do
      {:ok, _comment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Comment created successfully")}

      {:error, %Ecto.Changeset{}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Comment couldn't be created")}
    end
  end

  @impl true
  def handle_info({:comments_added, post}, socket) do
    {:noreply, assign(socket, post: post)}
  end

  @impl true
  def handle_info({:comments_deleted, post}, socket) do
    {:noreply, assign(socket, post: post)}
  end

  defp page_title(:show), do: "Show Post"
end
