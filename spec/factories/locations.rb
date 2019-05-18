FactoryBot.define do
  factory(:location) do
    book
    tune
    page {Random.rand(300)}
  end
end
