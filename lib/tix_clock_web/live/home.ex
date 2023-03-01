defmodule TixClockWeb.Home do
  use TixClockWeb, :live_view

  @tick_delay_ms 10000

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_after(@tick_delay_ms, self(), :tick)

    socket
    |> assign(spain_time: get_spain_time())
    |> assign(canada_time: get_canada_time())
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_info(:tick, socket) do
    :timer.send_after(@tick_delay_ms, self(), :tick)

    socket
    |> assign(spain_time: get_spain_time())
    |> assign(canada_time: get_canada_time())
    |> then(&{:noreply, &1})
  end

  defp get_spain_time do
    get_time(1)
    |> Enum.zip(["yellow-400", "red-500", "yellow-400", "red-500"])
  end

  defp get_canada_time do
    get_time(16)
    |> Enum.zip(["white", "red-500", "white", "red-500"])
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
