defmodule Tomd.Router.Tree do
    alias __MODULE__
    alias URI
    alias Pathlib, as: Path


    @schema [ meta: %{} ]
    @enforce_keys Keyword.keys(@schema)
    defstruct @schema

    def validate(self), do: self

    def new, do: []

    defp __find__(self, p, prev \\ {:ok, nil, nil})  # ret: {success, route_id, path_id}
    defp __find__(_, [], prev), do: prev  # eof
    defp __find__(self, ["/" | p], prev) do
        p |> Enum.with_index(1) |> (&__find__(&2, &1, prev)).(self)
    end
    defp __find__(self, ["" <> s | p], prev) do
        [s | p] |> Enum.with_index |> (&__find__(&2, &1, prev)).(self)
    end
    defp __find__(self = _routes, [{s, i} | p] = _path, {_, old_r_id, old_p_id}) do
        case cur_r_id = Enum.find_index(self,
            fn {^s, ^old_r_id, _} -> true
               _                  -> false
            end)
        do
            :nil -> {:error, old_r_id, i}
            #  :nil -> {:error, old_r_id, old_p_id}
            _    -> self |> __find__(p, {:ok, cur_r_id, i})
        end
    end

    def find(self, p) do  # todo: find for ["/" | p] & normalize
        case __find__(self, p) do
            {:ok, i, _} -> {:ok, Enum.at(self, i)}
            {:error, _, _} -> {:error, nil}
        end
    end

    defp __add__(self, [_|_], {:ok, _r_id, _p_id}), do: self

    defp __add__(self, path = [_|_], {:error, r_id, p_id}) do
        r_len = length(self)
        self ++ (path
                 |> Enum.take(p_id - length(path))
                 |> tl
                 |> Enum.reduce([ {Enum.at(path, p_id), r_id, nil} ],
                                fn x, acc ->
                                    [ { x, r_len + length(acc) - 1, nil } | acc ]
                                end)
                 |> Enum.reverse)
    end

    def add(self, "" <> path, payload \\ nil) do
        p =
        path
        |> Path.normalize
        |> Path.root_join

        # todo: result type railway -> {success, r, p, r_id, p_id}
        p
        |> (&__find__(self, &1)).()  # ret = {success, route_id, path_id}
        |> (&__add__(self, p, &1)).()
    end

end
