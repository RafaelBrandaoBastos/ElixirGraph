defmodule InfectionSpreader do
  import InfectionMethods
  import GraphMethods
  import Exporter

  # Função para atualizar o primeiro vértice para ficar infectado
  def create_infection(graph, i) do
    random = :rand.uniform(i)
    InfectionMethods.update_vertex_infected(graph, %Vertex{id: random}, true)
  end

  # Função para checar a condição dos vértices
  def check_for_infection(graph, n) do
    vertices_with_ids = Enum.to_list(graph.vertices)
    newgraph = infected_neighbors(vertices_with_ids, graph)

    if has_uninfected_nodes(newgraph) do
      check_for_infection(newgraph, n)
    end

    newgraph
  end

  # Função para checar se possui vértices não infectadasd
  defp has_uninfected_nodes(graph) do
    Enum.any?(graph.vertices, fn {_vertex_id, vertex} -> not vertex.infected end)
  end

  # Recursividade, retorno do grafo atualizado
  def infected_neighbors([], graph), do: graph

  # Recursividade, atualizar grafo para infectar vizinhos
  def infected_neighbors([{vertex_id, vertex} | rest], graph) do
    if vertex.infected do
      neighbors = get_vertice_neighbors(graph, vertex_id)
      IO.puts("!!!Neighbors on danger #{vertex_id}: #{inspect(neighbors)}")
      newgraph = traverse_neighbors_recursive(graph, neighbors)
      # Pass newgraph to the recursive call
      infected_neighbors(rest, newgraph)
    else
      IO.puts("Vertex #{vertex_id} not infected")
      # Continue recursion without modifying graph
      infected_neighbors(rest, graph)
    end
  end

  # Saber quais são os vizinhos
  defp get_vertice_neighbors(%{edges: edges}, vertex_id) do
    Map.get(edges, vertex_id, [])
  end

  # Recursividade, retorna o grafo com vizinhos infectados
  def traverse_neighbors_recursive(graph, []) do
    graph
  end

  # Recursividade, infecta um vizinho
  def traverse_neighbors_recursive(graph, [neighbor_id | rest]) do
    Exporter.print_to_dot(graph, "graph.dot")
    :timer.sleep(1000)
    IO.puts("RecursiveInfected #{neighbor_id}")

    newgraph =
      InfectionMethods.update_vertex_infected(
        graph,
        %Vertex{id: String.to_integer(neighbor_id)},
        true
      )

    traverse_neighbors_recursive(newgraph, rest)
  end
end
