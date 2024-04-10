defmodule InfectionSpreader do
  import InfectionMethods
  import GraphMethods
  import Exporter
  # Função para atualizar o primeiro vértice para ficar infectado
  def create_infection(graph, i) do
    random = :rand.uniform(i)
    InfectionMethods.update_vertex_infected(graph, %Vertex{id: random}, true)
  end

  def traverse_neighbors2(graph, n) do
    vertices_with_ids = Enum.to_list(graph.vertices)
    newgraph = traverse_vertices3(vertices_with_ids, graph)
    if has_uninfected_nodes(newgraph) do
      traverse_neighbors2(newgraph, n)
    end
    newgraph
  end
defp has_uninfected_nodes(graph) do
  Enum.any?(graph.vertices, fn {_vertex_id, vertex} -> not vertex.infected end)
end
def traverse_vertices3([], graph), do: graph

def traverse_vertices3([{vertex_id, vertex} | rest], graph) do
  IO.puts("check")
  if vertex.infected do
    neighbors = get_neighbors2(graph, vertex_id)
    IO.puts("!!!Neighbors on danger #{vertex_id}: #{inspect(neighbors)}")
    newgraph = traverse_neighbors_recursive(graph, neighbors)
    traverse_vertices3(rest, newgraph)  # Pass newgraph to the recursive call
  else
    IO.puts("Vertex #{vertex_id} not infected")
    traverse_vertices3(rest, graph)  # Continue recursion without modifying graph
  end
end



  def traverse_neighbors_recursive(graph, []) do
    graph
  end

  def traverse_neighbors_recursive(graph, [neighbor_id | rest]) do
    Exporter.print_to_dot(graph, "graph.dot")
    :timer.sleep(1000)
    IO.puts("RecursiveInfected #{neighbor_id}")
    newgraph = InfectionMethods.update_vertex_infected(graph, %Vertex{id: String.to_integer(neighbor_id)}, true)
    traverse_neighbors_recursive(newgraph, rest)
  end

  defp get_neighbors2(%{edges: edges}, vertex_id) do
    Map.get(edges, vertex_id, [])
  end
end
