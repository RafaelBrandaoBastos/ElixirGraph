defmodule Graph do
  # Define the struct for the graph
  defstruct vertices: %{}, edges: %{}

  # Function Add a vertex to the graph
  def add_vertex(graph, vertex) do
    %{graph | vertices: Map.put(graph.vertices, vertex, true)}
  end

  # Function  Add an edge to the graph
  def add_edge(graph, {from, to}) do
    updated_edges =
      Map.update(graph.edges, from, [], fn edges ->
        edges ++ [to]
      end)

    %{graph | edges: updated_edges}
  end

  # Function Print the graph
  def print(graph) do
    IO.puts("Vertices: #{inspect(Map.keys(graph.vertices))}")
    IO.puts("Edges: #{inspect(graph.edges)}")
  end

  def hello do
    IO.puts("Hello World!")
  end
end
