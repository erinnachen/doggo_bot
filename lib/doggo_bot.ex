defmodule DoggoBot do
  @moduledoc """
  Documentation for DoggoBot.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DoggoBot.hello
      :world

  """
  def main(_argv) do
    try do
      tweet = ExTwitter.user_timeline([screen_name: "dog_rates", count: 300])
        |> Enum.find(fn(tweet) -> !tweet.retweeted && !tweet.in_reply_to_user_id && tweet.retweet_count > 1000 end)
      if tweet do
        ExTwitter.retweet(tweet.id)
      end
    rescue
      err in ExTwitter.Error -> err
    end
  end
end
