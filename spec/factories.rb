FactoryBot.define do
    factory :user do
      username { "Pekka" }
      password { "Foobar1" }
      password_confirmation { "Foobar1" }
    end

    factory :brewery do
        name { "anonymous" }
        year { 1900 }
    end

    factory :beer do
        name { "anonymous" }
        brewery
        style
    end

    factory :ipa do
        name { "anonymous" }
        brewery
        ipa_style
    end

    factory :rating do
        score { 10 }
        beer
        user
    end

    factory :style do
        name { "Test style" }
        description { "" }
    end

    factory :ipa_style do
        name { "IPA" }
        description { "" }
    end
end