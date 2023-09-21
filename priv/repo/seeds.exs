# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, post} =
  Blog.Posts.create_post(%{
    "author" => "Joanne Dark",
    "title" => "Interesting Post",
    "summary" => "A post concerning an interesting topic",
    "content" => "Interesting content"
  })

Blog.Posts.create_comment(%{
  "author" => "Katherine Curcuma",
  "content" => "You make an interesting point!",
  "post_id" => post.id
})

Blog.Posts.create_comment(%{
  "author" => "Anthony Moriarity",
  "content" => " I disagree, but I respect your point!",
  "post_id" => post.id
})

Blog.Posts.create_comment(%{
  "author" => "Janice Truffle",
  "content" => "I never thought of that! How clever!",
  "post_id" => post.id
})

Blog.Posts.create_comment(%{
  "author" => "Anna Frozen",
  "content" => "I experienced that once, it gave me a week long headache!",
  "post_id" => post.id
})
