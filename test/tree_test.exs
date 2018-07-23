defmodule TreeTest do
    use ExUnit.Case, async: true
    alias Tomd.Router.Tree

    @r [  {"home", nil, nil},
          {"file.txt", 2, nil},
          {"user", 0, nil}  ]

    test "add path to root" do
        assert @r |> Tree.__find__(["var"])
               == {:error, nil, 0}
    end

    test "add empty path" do
      assert @r |> Tree.__find__([])
             == {:ok, nil, nil}
    end

    test "add sub path" do
        assert @r |> Tree.add("/home/user/file.txt")
               == [ {"home", nil, nil},
                    {"file.txt", 2, nil},
                    {"user", 0, nil},
                    {"image.jpeg", 2, nil} ]
    end

    test "add over path" do
        assert [{"home", nil, nil}, {"arc.zip", 2, nil}, {"user", 0, nil}]
               |> Tree.add("/home/user/arc.zip/doc.txt")
               == [{"home", nil, nil}, {"arc.zip", 2, nil}, {"user", 0, nil}, {"doc.txt", 1, nil}]
    end
end
