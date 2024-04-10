defmodule InfectionMethods do
  def update_vertex_infected(graph, vertex, infected) do
  #IO.puts("$$$$update_vertex_infected Recebeu #{vertex.id} de #{vertex.infected} para #{infected}")
    updated_vertices =
      Map.update(graph.vertices, vertex.id, nil, fn v ->
        %Vertex{id: v.id, infected: infected}
      end)
    #IO.puts("$$$$update_vertex_infected retornou #{inspect(updated_vertices)}")
    %{graph | vertices: updated_vertices}
  end
end
