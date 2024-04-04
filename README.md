iex ProjetoLP.main
<p>elixirc</p>
elixir
mix deps.get
mix run --no-halt
hot code reloading
iex -S mix
<P>graph = %{
  vertices: %{"a" => true, "b" => true, "c" => true},
  edges: %{"a" => ["b"], "b" => ["a", "c"], "c" => ["b"]}
}

GraphTraversal.traverse_neighbors(graph)</P>
