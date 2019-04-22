FactoryBot.define do
  factory(:tune) do
    sequence(:title) {|n| "#{FFaker::Music.song} #{n}"}

    trait :with_location do |tune|
      after(:create) do |tune|
        tune.add_location((1..1000).sample, create(:book))
      end
    end
  end
end
