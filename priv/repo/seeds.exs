# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jobber.Repo.insert!(%Jobber.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Jobber.Accounts

company_data = [
  %{
    name: "Apple",
    industry: "Computing and Technology",
    year_founded: "1976",
    logo: "https://i.imgur.com/2FG5cuq.png"
  },
  %{
    name: "Microsoft",
    industry: "Computing and Technology",
    year_founded: "1975",
    logo: "https://i.imgur.com/8V31qzJ.png"
  },
  %{
    name: "Twitter",
    industry: "Social Networking",
    year_founded: "2006",
    logo: "https://i.imgur.com/TXRNqdk.png"
  },
  %{
    name: "Google",
    industry: "Internet, Cloud Computing, Marketing",
    year_founded: "1998",
    logo: "https://i.imgur.com/o4IH25s.png"
  }
]

Enum.each(company_data, fn data ->
  Accounts.create_company(data)
end)
