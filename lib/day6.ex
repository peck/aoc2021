#all the process modeling was useless :(, too much memory usage with exponential growth, oh well!
#defmodule AnglerFish do
#  defstruct [:pop_pid, timer: 8]
#
#  alias Phoenix.PubSub
#
#  use GenServer
#
#  require Logger
#
#  def start_link(default) when is_list(default) do
#       GenServer.start_link(__MODULE__, default)
#  end
#
#  def start(default) when is_list(default) do
#       GenServer.start(__MODULE__, default)
#  end
#
#  @impl true
#  def init([timer, pop_pid]) do
#    {:ok, _} = Registry.register(Registry.Ticker, "angler_fish", {IO, :inspect})
#    {:ok, %__MODULE__{pop_pid: pop_pid, timer: timer}}
#  end
#
#  def handle_call({:tick}, _sender, state) do
#    new_timer = case state.timer do
#                  0 ->
#                    GenServer.call(state.pop_pid, {:new_anglerfish})
#                    6
#                  _ ->
#                    state.timer - 1
#    end
#
#    {:reply, :ok, %{state | timer: new_timer }}
#  end
#
#  def handle_info({:die}, state) do
#    {:stop, :killed, %{}}
#  end
#
#    def terminate(reason, state) do
#    # Do Shutdown Stuff
#    :normal
#  end
#
#end
#
#defmodule Ocean do
#  defstruct []
#
#  use GenServer
#
#  require Logger
#
#  def start_link(default) when is_list(default) do
#       GenServer.start_link(__MODULE__, default)
#  end
#
#  def start(default) when is_list(default) do
#       GenServer.start(__MODULE__, default)
#  end
#
#  @impl true
#  def init(_default) do
#    {:ok, %{}}
#  end
#
#  def handle_call({:new_anglerfish}, _from, state) do
#    AnglerFish.start([8, self()])
#    {:reply, :ok, state}
#  end
#
#end

defmodule Day6 do
  require Logger

#  def send_tick() do
#    Registry.dispatch(Registry.Ticker, "angler_fish", fn entries ->
#    Logger.debug("Entries has #{Enum.count(entries)}")
#  for {pid, _} <- entries, do: GenServer.call(pid, {:tick})
#end)
#  end
#
#  def send_die() do
#    Registry.dispatch(Registry.Ticker, "angler_fish", fn entries ->
#  for {pid, _} <- entries, do: send(pid, {:die})
#end)
#  end
#
#  def start_reg() do
#    {:ok, _} =
#  Registry.start_link(
#    keys: :duplicate,
#    name: Registry.Ticker,
#    partitions: 1
#  )
#    end

  def part1(starting_pop, iterations) do
    acc = %{
      0 => 0,
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 0,
      6 => 0,
      7 => 0,
      8 => 0,
    }
    pop_map =
    starting_pop
    |> Enum.frequencies()
    |> Map.merge(acc, fn _k, v1, v2 -> v1 end)

    Enum.reduce(0..iterations, pop_map, fn(_x, acc) -> tick(acc) end)
  end

  def tick(population = %{}) do
    starter = %{
      0 => 0,
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 0,
      6 => 0,
      7 => 0,
      8 => 0,
    }

    population
    |> Enum.reduce(starter, fn({k,v}, acc) ->
      case k do
        0 ->
          {_, ret} =
            acc
          |> Map.put(8, v)
            |> Map.get_and_update(6, fn(current_value) -> {current_value, current_value + v} end)
          ret

        7 ->
          {_, ret} =
            acc
            |> Map.get_and_update(6, fn(current_value) -> {current_value, current_value + v} end)
          ret

        num ->
          Map.put(acc, num - 1, v)
      end
    end)
  end
end
