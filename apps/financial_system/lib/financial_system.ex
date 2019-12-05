defmodule FinancialSystem do
  @moduledoc """
  Documentation for FinancialSystem.
  """
  alias FinancialSystem.Repo
  alias FinancialSystem.Transaction
  alias FinancialSystem.Money

  @doc """
  Convert currencies

    ##Examples
      iex> FinancialSystem.convert("BRL", "USD", 100)
      iex> FinancialSystem.convert("BRL", "EUR", 100)
      iex> ""
      ""
  """
  def convert(currency_from, currency_to, value) do
    response = HTTPotion.get "https://free.currconv.com/api/v7/convert?q=#{currency_from}_#{currency_to}&compact=ultra&apiKey=054cd862198124567d1a"
    body = response.body |> Poison.decode!
    if body["#{currency_from}_#{currency_to}"] do
      value = value |> Money.get_value(currency_from)
      currency_value = body["#{currency_from}_#{currency_to}"]
      {:ok, (value*currency_value) |> Float.round(2) |> Money.parse_value(currency_to)}
    else
      {:error, "Data Invalid, verify currencies"}
    end
  end

  @doc """
  Transfer and split values to transfer

    ##Examples
      iex> {:ok, user} = FinancialSystem.Transaction.create_user(%{name: "Name client", email: "email@email.com", phone: "86984948928"})
      iex> {:ok, account} = FinancialSystem.Transaction.create_account(%{balance: 200, currency: "BRL", user_id: user.id})
      iex> {:ok, user1} = FinancialSystem.Transaction.create_user(%{name: "Name client1", email: "email1@email.com", phone: "86984948928"})
      iex> {:ok, account1} = FinancialSystem.Transaction.create_account(%{balance: 200, currency: "BRL", user_id: user1.id})
      iex> {:ok, user2} = FinancialSystem.Transaction.create_user(%{name: "Name client2", email: "email2@email.com", phone: "86984948928"})
      iex> {:ok, account2} = FinancialSystem.Transaction.create_account(%{balance: 200, currency: "BRL", user_id: user2.id})
      iex> {:ok, %FinancialSystem.Transaction.Transfer{}} = FinancialSystem.transfer(account.id, [%{value: 30.1, account_received_id: account1.id}, %{value: 40, account_received_id: account2.id}])
      iex> {:error, %FinancialSystem.Transaction.Transfer{}} = FinancialSystem.transfer(account.id, [%{value: 300.20, account_received_id: account1.id}, %{value: 40, account_received_id: account2.id}])
      iex> ""
      ""
  """
  def transfer(account_from_id, accounts) do
    account = Transaction.get_account!(account_from_id)
    value = accounts |> Enum.map(&(Money.parse_value(&1.value, account.currency))) |> Enum.reduce(0, &(&1+&2))
    #Register transfer
    case register_transfer(account_from_id, value) do
      {:ok, transfer} ->
        items = accounts |> Enum.map(fn register ->
          {:ok, item} = register_item(Money.parse_value(register.value, account.currency), register.account_received_id, transfer.id, account.currency)
          item
        end)
        case Repo.transaction(fn ->
          items |> Enum.map(fn item ->
            transfer_account(account_from_id, item.account_received_id, item)
          end)

          "Successful transfer"
        end) do
          {:ok, message} ->
            update_transfer(transfer, true, message)
          {:error, message} ->
            {_, transfer} = update_transfer(transfer, false, message)
            {:error, transfer}
        end
      {:error, _} ->
        {:error, "Canceled transfer verify info"}
    end
  end

  @doc """
  Transfer values to one account

    ##Examples
      iex> {:ok, user} = FinancialSystem.Transaction.create_user(%{name: "Name client", email: "email@email.com", phone: "86984948928"})
      iex> {:ok, account} = FinancialSystem.Transaction.create_account(%{balance: 200, currency: "BRL", user_id: user.id})
      iex> {:ok, user1} = FinancialSystem.Transaction.create_user(%{name: "Name client1", email: "email1@email.com", phone: "86984948928"})
      iex> {:ok, account1} = FinancialSystem.Transaction.create_account(%{balance: 200, currency: "BRL", user_id: user1.id})
      iex> {:ok, %FinancialSystem.Transaction.Transfer{}} = FinancialSystem.transfer(account.id, account1.id, 100)
      iex> {:error, %FinancialSystem.Transaction.Transfer{}} = FinancialSystem.transfer(account.id, account1.id, 1000)
      iex> ""
      ""
  """
  def transfer(account_from_id, account_received_id, value) do
    account = Transaction.get_account!(account_from_id)
    #Register transfer
    case register_transfer(account_from_id, Money.parse_value(value, account.currency)) do
      {:ok, transfer} ->
        {:ok, item} = register_item(transfer.value, account_received_id, transfer.id, account.currency)

        case Repo.transaction(fn ->
          #Register item of transfer

          transfer_account(account_from_id, account_received_id, item)

        end) do
          {:ok, message} ->
            #Updated transfer with status and reason
            update_transfer(transfer, true, message)
          {:error, message} ->
            #Updated transfer with status and reason
            {_, transfer} = update_transfer(transfer, false, message)
            {:error, transfer}
        end
      {:error, _} ->
        {:error, "Canceled transfer verify info"}
    end
  end

  defp transfer_account(account_from_id, account_received_id, item) do
    account_from = Transaction.get_account!(account_from_id)
    account_received = Transaction.get_account!(account_received_id)

    if account_from.balance >= item.value do

      #Updated balance for account from
      case Transaction.update_account(account_from, %{balance: account_from.balance - item.value}) do
        {:ok, _} ->
          "Successful transfer"
        {:error, _} ->
          Repo.rollback("Canceled transfer verify info")
      end

      #Updated balance for account received
      case Transaction.update_account(account_received, %{balance: account_received.balance + item.value}) do
        {:ok, _} ->
          "Successful transfer"
        {:error, _} ->
          Repo.rollback("Canceled transfer verify info")
      end
    else
      Repo.rollback("Insufficient funds")
    end
  end

  defp register_item(value, account_received_id, transfer_id, currency) do
    case Transaction.create_item(%{value: value, currency: currency, account_received_id: account_received_id, transfer_id: transfer_id}) do
      {:ok, item} ->
        {:ok, item}
      {:error, _} ->
        Repo.rollback("Canceled transfer verify info")
    end
  end

  defp update_transfer(transfer, status, message) do
    case Transaction.update_transfer(transfer, %{success: status, reason: message}) do
      {:ok, transfer} ->
        {:ok, transfer}
      {:error, _} ->
        {:error, transfer}
    end
  end

  defp register_transfer(account_id, value) do
    case Transaction.create_transfer(%{value: value, account_id: account_id, reason: "Created Transfer", success: false}) do
      {:ok, transfer} ->
        {:ok, transfer}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end

end
