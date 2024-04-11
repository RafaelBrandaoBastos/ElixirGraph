defmodule GraphMethods do
  defstruct vertices: %{}, edges: %{}

  # Adiciona um vértice
  def add_vertex(graph, vertex) do
    updated_vertices = Map.put(graph.vertices, vertex.id, vertex)
    # IO.puts("Created Vertice #{vertex.id}")
    %{graph | vertices: updated_vertices}
  end

  # Adiciona uma aresta
  def add_edge(graph, from, to) do
    # IO.puts("Add edge #{from} to #{to}")
    edges = Map.update(graph.edges, from, [to], fn existing_edges -> [to | existing_edges] end)
    %{graph | edges: edges}
  end

  # Viaja pelo grafo
  def traverse(graph) do
    traverse_vertices(graph.vertices)
  end

  # Viaja pelos vertices
  def traverse_vertices(%{} = vertices) do
    Enum.each(vertices, fn {vertex_id, vertex} ->
      vertex_infected = get_infected(vertex)
      # IO.puts("Visiting vertex: #{vertex_id} infectado:#{vertex_infected}")
    end)
  end

  # Obtém o status de infecção de um vértice
  def get_infected(vertex) do
    vertex.infected
  end

  # Viaja Pelos vizinhos de um vértice
  def traverse_neighbors(graph) do
    Enum.each(graph.vertices, fn {vertex_id, _} ->
      neighbors = get_neighbors(graph, vertex_id)
      # IO.puts("Neighbors of vertex #{vertex_id}: #{inspect(neighbors)}")
    end)
  end

  # Obtém os vizinhos de um vértice
  defp get_neighbors(%{edges: edges}, vertex_id) do
    Map.get(edges, vertex_id, [])
  end
end
