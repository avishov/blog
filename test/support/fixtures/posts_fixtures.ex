defmodule Blog.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        title: "some title",
        author: "some author",
        summary: "some summary",
        content: "some content"
      })
      |> Blog.Posts.create_post()

    post |> Blog.Repo.preload(:comments)
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content",
        post_id: post_fixture().id
      })
      |> Blog.Posts.create_comment()

    comment |> Blog.Repo.preload(:post)
  end
end
