FactoryBot.define do
  factory(:book) do
    title {FFaker::Book.title}
    offset {0}
  end
end
