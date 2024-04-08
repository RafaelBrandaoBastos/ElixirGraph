defmodule Main do
  # Importa as funções do módulo Graph
  import Graph
  import Exporter

  # Definição da struct Vertex dentro do módulo Main
  defmodule Vertex do
    defstruct nome: nil, id: nil, infected: nil
  end

  def run do
    # Cria um novo grafo vazio
    graph = %Graph{}
    graphsize = 10
    graph_with_vertices = add_vertices(graph, graphsize)
    graph_with_edges = add_edges(graph_with_vertices, graphsize, graphsize)
    traverse(graph_with_edges)
    traverse_neighbors(graph_with_edges)
    Exporter.print_to_dot(graph_with_edges, "graph.dot")
  end

  # Função para adicionar vértices ao grafo recursivamente
  # Caso base: quando n é igual a 1
  def add_vertices(graph, 1) do
    vertex = %Vertex{id: 1}
    add_vertex(graph, vertex)
  end

  # Caso recursivo: quando n é maior que 1
  def add_vertices(graph, n) when n > 0 do
    updated_graph = add_vertex(graph, %Vertex{id: n})
    add_vertices(updated_graph, n - 1)
  end

  # Função para adicionar arestas ao grafo recursivamente
  # Caso base: quando n é igual a 1
  def add_edges(graph, 1, i) do
    random = generate_random(1, i)
    updated_graph = add_edge(graph, 1, 2)
    add_edge(updated_graph, 1, "#{random}")
  end

  # Gera numero randomico
  defp generate_random(n, i) do
    random = :rand.uniform(i)

    if random == n do
      generate_random(n, i)
    else
      random
    end
  end

  # Caso recursivo: quando n é maior que 1
  def add_edges(graph, n, i) when n > 0 do
    if n == i do
      prev = n - 1
      random = generate_random(n, i)
      updated_graph = add_edge(graph, n, Integer.to_string(prev))
      updated_graph2 = add_edge(updated_graph, n, Integer.to_string(random))
      add_edges(updated_graph2, n - 1, i)
    else
      prev = n - 1
      next = n + 1
      random = generate_random(n, i)

      updated_graph = add_edge(graph, n, Integer.to_string(prev))
      updated_graph2 = add_edge(updated_graph, n, Integer.to_string(next))
      updated_graph3 = add_edge(updated_graph2, n, Integer.to_string(random))
      add_edges(updated_graph3, n - 1, i)
    end
  end
end
