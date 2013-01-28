# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :url, class: 'Tenanfy::Url' do
    association :tenant
    url  { "www.test#{Random.rand(100)}.com" }
  end
end

