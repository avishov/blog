defmodule BlogWeb.BlogController do
  use BlogWeb, :controller

  alias Blog.Posts

  plug :put_layout, html: {BlogWeb.Layouts, :blog}

  def index(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

    posts = Posts.list_posts()

    render(conn, :index, posts: posts)
  end
end
