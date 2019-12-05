defmodule FinancialSystemWeb.Api.TransferView do
  use FinancialSystemWeb, :view

  def render("index.json", %{transfers: transfers}) do
    %{data: render_many(transfers, FinancialSystemWeb.Api.TransferView, "transfer.json")}
  end

  def render("transfer.json", %{transfer: transfer}) do
    transfer
  end

  def render("errors.json", %{changeset: changeset}) do
    %{data: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end


end
