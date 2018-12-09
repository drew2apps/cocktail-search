FactoryBot.define do
  factory :recipe do
    title { "Test Recipe" }
    instructions { "This is test instructions" }
    glass { "Test Glass" }
    alcoholic { "Alcoholic" }
  end
end