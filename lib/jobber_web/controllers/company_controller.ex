defmodule JobberWeb.CompanyController do
  use JobberWeb, :controller

  alias Jobber.Accounts

  def index(conn, _params) do
    companies = Accounts.list_companies()
    render(conn, "index.html", companies: companies)
  end

  def show(conn, %{"id" => id}) do
    company = Accounts.get_company!(id)
    render(conn, "show.html", company: company)
  end
end
