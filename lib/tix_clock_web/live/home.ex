defmodule TixClockWeb.Home do
  use TixClockWeb, :live_view

  @tick_delay_ms 60000

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(@tick_delay_ms, self(), :tick)

    socket
    |> assign(time: get_time())
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_info(:tick, socket) do
    socket
    |> assign(time: get_time())
    |> then(&{:noreply, &1})
  end

  defp get_time do
    get_time(1)
  end

  defp get_time(timezone_offset) do
    {_, {hh, mm, _}} = :calendar.local_time()

    hh = rem(hh + timezone_offset, 24)

    [
      get_time_list(div(hh, 10), 3),
      get_time_list(rem(hh, 10), 9),
      get_time_list(div(mm, 10), 6),
      get_time_list(rem(mm, 10), 9)
    ]
  end

  defp get_time_list(num, max), do: for(i <- 1..max, do: i <= num) |> Enum.shuffle()
end
