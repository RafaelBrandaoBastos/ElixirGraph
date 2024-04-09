defmodule Exporter do
  import GraphMethods

  def print_to_dot(graph, filename) do
    full_path = "#{filename}"
    File.write!(full_path, generate_dot_content(graph))
    IO.puts("Arquivo #{full_path} gerado com sucesso!")
  end

  defp generate_dot_content(graph) do
    nodes =
      Enum.map(graph.vertices, fn {vertex_id, vertex} ->
        vertex_infected = Map.get(vertex, :infected, false)
        fillcolor = if vertex_infected, do: "red", else: "lightblue"
        # IO.puts("Visiting vertex: #{vertex}")
        neighbors = get_neighbors(graph, vertex_id)
        vertex_id_str = to_string(vertex_id)

        edges =
          Enum.map(neighbors, fn neighbor ->
            "#{vertex_id_str} -> #{neighbor}[penwidth=4];"
          end)

        [
          "#{vertex_id_str} [label=\"#{vertex_id_str}\", fillcolor=\"#{fillcolor}\", style=\"filled\", shape=\"circle\"];",
          edges
        ]
      end)
      |> List.flatten()

    "digraph G {\n" <>
      "#{Enum.join(nodes, "\n  ")}\n" <>
      "}\n"
  end

  defp get_neighbors(%{edges: edges}, vertex) do
    Map.get(edges, vertex, [])
  end
end
