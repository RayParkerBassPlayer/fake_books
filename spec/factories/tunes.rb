FactoryBot.define do
  factory(:tune) do
    sequence(:title) {|n| "#{FFaker::Music.song} #{n}"}

    trait :with_location do |tune|
      after(:create) do |tune|
        tune.add_location(:page => (1..1000).sample, :book => create(:book))
      end
    end
  end
end
