defmodule Graph do
  defstruct vertices: %{}, edges: %{}

  def add_vertex(graph, vertex) do
    %{graph | vertices: Map.put(graph.vertices, vertex, true)}
  end

  def add_edge(graph, from, to) do
    edges = Map.update(graph.edges, from, [to], fn existing_edges -> [to | existing_edges] end)
    %{graph | edges: edges}
  end

  def traverse(graph) do
    traverse_vertices(graph.vertices)
  end

  defp traverse_vertices(%{} = vertices) do
    Enum.each(vertices, fn {vertex, _} ->
      IO.puts("Visiting vertex: #{vertex}")
    end)
  end

  def traverse_neighbors(graph) do
    Enum.each(graph.vertices, fn {vertex, _} ->
      neighbors = get_neighbors(graph, vertex)
      IO.puts("Neighbors of vertex #{vertex}: #{inspect(neighbors)}")
    end)
  end

  defp get_neighbors(%{edges: edges}, vertex) do
    Map.get(edges, vertex, [])
  end
end
