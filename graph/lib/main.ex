# Definição da struct Vertex dentro do módulo Main
defmodule Vertex do
  defstruct nome: nil, id: nil, infected: false
end

defmodule Main do
  # Importa as funções do módulo Graph
  import GraphMethods
  import GraphCreator
  import InfectionMethods
  import InfectionSpreader
  import Exporter

  def graph_generator do
    graph = %GraphMethods{}
    graphsize = 10
    graph_with_vertices = add_vertices(graph, graphsize)
    graph_with_edges = add_edges(graph_with_vertices, graphsize, graphsize)
    traverse(graph_with_edges)
    traverse_neighbors(graph_with_edges)
    Exporter.print_to_dot(graph_with_edges, "graph.dot")
  end

  def start_infection do
    graph = %GraphMethods{}
    graphsize = 10
    graph_with_vertices = add_vertices(graph, graphsize)
    graph_with_edges = add_edges(graph_with_vertices, graphsize, graphsize)
    graph_with_infected = create_infection(graph_with_edges, graphsize)
    traverse_neighbors2(graph_with_infected, graphsize)
  end
end
