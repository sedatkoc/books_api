defmodule BooksApi.StoreTest do
  use BooksApi.DataCase

  alias BooksApi.Store

  describe "books" do
    alias BooksApi.Store.Book

    @valid_attrs %{"\"": "some \""}
    @update_attrs %{"\"": "some updated \""}
    @invalid_attrs %{"\"": nil}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_book()

      book
    end

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Store.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Store.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Store.create_book(@valid_attrs)
      assert book." == "some \""
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, %Book{} = book} = Store.update_book(book, @update_attrs)
      assert book." == "some updated \""
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_book(book, @invalid_attrs)
      assert book == Store.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Store.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Store.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Store.change_book(book)
    end
  end
end
