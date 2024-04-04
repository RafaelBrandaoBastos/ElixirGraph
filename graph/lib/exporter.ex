defmodule Exporter do
  def print_to_dot(graph, filename) do
    full_path = "#{filename}"
    File.write!(full_path, generate_dot_content(graph))
    IO.puts("Arquivo #{full_path} gerado com sucesso!")
  end

  defp generate_dot_content(graph) do
    nodes =
      Enum.map(graph.vertices, fn {vertex, _} ->
        IO.puts("Visiting vertex: #{vertex}")
        neighbors = get_neighbors(graph, vertex)

        edges =
          Enum.map(neighbors, fn neighbor ->
            "#{vertex} -> #{neighbor}[penwidth=4];"
          end)

        [
          "#{vertex} [label=\"#{vertex}\", fillcolor=\"lightblue\", style=\"filled\", shape=\"circle\"];",
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
