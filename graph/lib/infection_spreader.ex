defmodule InfectionSpreader do
  import InfectionMethods
  import GraphMethods
  # Função para atualizar o primeiro vértice para ficar infectado
  def create_infection(graph, i) do
    random = :rand.uniform(i)
    InfectionMethods.update_vertex_infected(graph, %Vertex{id: random}, true)
  end

  def traverse_neighbors2(graph, n) when n > 0 do
    IO.puts("Neighbors on danger")

    Enum.each(graph.vertices, fn {vertex_id, vertex} ->
      if vertex.infected == true do
        neighbors = get_neighbors2(graph, vertex_id)
        IO.puts("Neighbors on danger #{vertex_id}: #{inspect(neighbors)}")
        traverse_neighbors_recursive(graph, neighbors)

        # Enum.each(neighbors, fn neighbor_id ->
        # IO.puts("Infected #{neighbor_id}")
        # newgraph =
        # InfectionMethods.update_vertex_infected(graph, %Vertex{id: neighbor_id}, true)
        # end)
      end
    end)
  end

  def traverse_neighbors_recursive(graph, [neighbor_id | rest]) do
    IO.puts("Infected #{neighbor_id}")

    newgraph =
      InfectionMethods.update_vertex_infected(graph, %Vertex{id: neighbor_id}, true)

    GraphMethods.traverse(newgraph)

    traverse_neighbors_recursive(newgraph, rest)
  end

  defp get_neighbors2(%{edges: edges}, vertex_id) do
    Map.get(edges, vertex_id, [])
  end
end
