defmodule Pathlib do
    @doc """
    user -> /user
    """
    def root_join(["/" | _] = paths), do: paths
    def root_join(paths), do: ["/" | paths]

    @doc """
    .././home/../user//./user/.. -> user
    """
    def normalize(path) do
        path
        |> :filename.split
        |> Enum.reduce([],
            fn(e, a) ->
            case {e, a} do
                {".", _} -> a
                {"..", []} -> a
                {"..", _} -> a |> Enum.take(-length(a) + 1)
                {_, _} -> [e | a]
            end end)
        |> Enum.reverse
    end

    # todo: ~r/[\w\d-_]+/iu
end
