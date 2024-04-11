defmodule InfectionMethods do
  # Infectar um vértice informado")
  def update_vertex_infected(graph, vertex, infected) do
    updated_vertices =
      Map.update(graph.vertices, vertex.id, nil, fn v ->
        %Vertex{id: v.id, infected: infected}
      end)

    %{graph | vertices: updated_vertices}
  end
end
