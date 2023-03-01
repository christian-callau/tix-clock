defmodule TixClockWeb.Home do
  use TixClockWeb, :live_view

  @tick_delay_ms 10000

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_after(@tick_delay_ms, self(), :tick)

    socket
    |> assign(time: get_time())
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_info(:tick, socket) do
    :timer.send_after(@tick_delay_ms, self(), :tick)

    socket
    |> assign(time: get_time())
    |> then(&{:noreply, &1})
  end

  defp get_time do
    {_, {hh, mm, _}} = :calendar.local_time()

    [
      %{digit: get_time_list(div(hh, 10), 3), color: "green-400"},
      %{digit: get_time_list(rem(hh, 10), 9), color: "cyan-500"},
      %{digit: get_time_list(div(mm, 10), 6), color: "yellow-400"},
      %{digit: get_time_list(rem(mm, 10), 9), color: "red-500"}
    ]
  end

  defp get_time_list(num, max), do: for(i <- 1..max, do: i <= num) |> Enum.shuffle()
end
