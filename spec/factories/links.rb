# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    url        { Faker::Internet.url }
    short_url  { Faker::Number.hexadecimal(6) }
  end
end
