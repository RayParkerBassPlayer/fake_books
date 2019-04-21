FactoryBot.define do
  factory(:tune) do
    title { FFaker::Music.song }

    trait :with_location do |tune|
      after(:create) do |tune|
        tune.add_location((1..1000).sample, create(:book))
      end
    end
  end
end
