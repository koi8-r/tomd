defmodule PathlibTest do
    use ExUnit.Case, async: true
    import Pathlib

    test "Path is absolute and begin from root" do
        assert ["home", "user"] |> root_join |> :filename.join === "/home/user"
    end

    test "Hard path parse" do
        assert "./../home/../user//./user/.." |> normalize |> root_join === ["/", "user"]
    end

    test "Empty path" do
        assert "" |> normalize === []
        assert "." |> normalize === []
        assert ".." |> normalize === []
        assert ".././.." |> normalize === []
    end
end
